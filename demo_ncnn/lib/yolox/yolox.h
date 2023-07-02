#pragma once

#ifdef __cplusplus
extern "C" {
#endif

typedef int yolox_err_t;

#define YOLOX_OK        0
#define YOLOX_ERROR    -1

struct YoloX {
  const char *model_path;   // path to model file
  const char *param_path;   // path to param file

  float nms_thresh;   // nms threshold
  float conf_thresh;  // threshold of bounding box prob
  float target_size;  // target image size after resize, might use 416 for small model
};

struct Rect {
  float x;
  float y;
  float w;
  float h;
};

struct Object {
  int label;
  float prob;
  struct Rect rect;
};

struct DetectResult {
  int object_num;
  struct Object *object;
};

struct YoloX *yolox_create();
void yolox_destroy(struct YoloX *yolox);

struct DetectResult *detect_result_create();
void detect_result_destroy(struct DetectResult *result);

yolox_err_t detect(struct YoloX *yolox, const char *image_path, struct DetectResult *result);

#ifdef __cplusplus
}
#endif
