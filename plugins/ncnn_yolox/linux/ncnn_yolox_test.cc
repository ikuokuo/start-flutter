#include "ncnn_yolox.h"

#include <cstdio>
#include <string>

#if defined(USE_NCNN_SIMPLEOCV)
#include "simpleocv.h"
#else
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#endif

static void draw_objects(const char *image_path, DetectResult *detect_result);

int main(int argc, char const *argv[]) {
  (void)argc;
  (void)argv;

  std::string assets_dir("../assets/");
  std::string image_path = assets_dir + "dog.jpg";
  std::string model_path = assets_dir + "yolox_nano_fp16.bin";
  std::string param_path = assets_dir + "yolox_nano_fp16.param";

  auto yolox = yoloxCreate();
  yolox->model_path = model_path.c_str();
  yolox->param_path = param_path.c_str();
  yolox->nms_thresh  = 0.45;
  yolox->conf_thresh = 0.25;
  yolox->target_size = 416;
  // yolox->target_size = 640;

  auto detect_result = detectResultCreate();

  auto err = detectWithImagePath(yolox, image_path.c_str(), detect_result);
  if (err == YOLOX_OK) {
    auto num = detect_result->object_num;
    printf("yolox detect ok, num=%d\n", num);
    for (int i = 0; i < num; i++) {
      Object *obj = detect_result->object + i;
      printf("  object[%d] label=%d prob=%.2f rect={x=%.2f y=%.2f w=%.2f h=%.2f}\n",
        i, obj->label, obj->prob, obj->rect.x, obj->rect.y, obj->rect.w, obj->rect.h);
    }
  } else {
    printf("yolox detect fail, err=%d\n", err);
  }

  draw_objects(image_path.c_str(), detect_result);

  detectResultDestroy(detect_result);
  yoloxDestroy(yolox);
  return 0;
}

static void draw_objects(const char *image_path, DetectResult *detect_result) {
  static const char* class_names[] = {
    "person", "bicycle", "car", "motorcycle", "airplane", "bus", "train", "truck", "boat", "traffic light",
    "fire hydrant", "stop sign", "parking meter", "bench", "bird", "cat", "dog", "horse", "sheep", "cow",
    "elephant", "bear", "zebra", "giraffe", "backpack", "umbrella", "handbag", "tie", "suitcase", "frisbee",
    "skis", "snowboard", "sports ball", "kite", "baseball bat", "baseball glove", "skateboard", "surfboard",
    "tennis racket", "bottle", "wine glass", "cup", "fork", "knife", "spoon", "bowl", "banana", "apple",
    "sandwich", "orange", "broccoli", "carrot", "hot dog", "pizza", "donut", "cake", "chair", "couch",
    "potted plant", "bed", "dining table", "toilet", "tv", "laptop", "mouse", "remote", "keyboard", "cell phone",
    "microwave", "oven", "toaster", "sink", "refrigerator", "book", "clock", "vase", "scissors", "teddy bear",
    "hair drier", "toothbrush"
  };

  cv::Mat image = cv::imread(image_path, 1);
  if (image.empty()) {
    fprintf(stderr, "cv::imread %s failed\n", image_path);
    return;
  }

  for (size_t i = 0; i < detect_result->object_num; i++) {
    const Object& obj = *(detect_result->object + i);

    // fprintf(stderr, "%d = %.5f at %.2f %.2f %.2f x %.2f\n", obj.label, obj.prob,
    //         obj.rect.x, obj.rect.y, obj.rect.w, obj.rect.h);

    auto rect = cv::Rect_<float>(obj.rect.x, obj.rect.y, obj.rect.w, obj.rect.h);
    cv::rectangle(image, rect, cv::Scalar(255, 0, 0));

    char text[256];
    sprintf(text, "%s %.1f%%", class_names[obj.label], obj.prob * 100);

    int baseLine = 0;
    cv::Size label_size = cv::getTextSize(text, cv::FONT_HERSHEY_SIMPLEX, 0.5, 1, &baseLine);

    int x = obj.rect.x;
    int y = obj.rect.y - label_size.height - baseLine;
    if (y < 0)
      y = 0;
    if (x + label_size.width > image.cols)
      x = image.cols - label_size.width;

    cv::rectangle(image, cv::Rect(cv::Point(x, y), cv::Size(label_size.width, label_size.height + baseLine)),
                  cv::Scalar(255, 255, 255), -1);

    cv::putText(image, text, cv::Point(x, y + label_size.height),
                cv::FONT_HERSHEY_SIMPLEX, 0.5, cv::Scalar(0, 0, 0));
  }

  cv::imshow("image", image);
  cv::waitKey(0);
}
