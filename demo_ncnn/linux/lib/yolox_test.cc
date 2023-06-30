#include "yolox.h"

#include <cstdio>

int main(int argc, char const *argv[]) {
  auto imagepath = argv[1];

  auto objects = objects_create();

  auto err = objects_detect(imagepath, objects);
  if (err == YO_OK) {
    printf("yolox detect ok, num=%d\n", objects->num);
    for (int i = 0; i < objects->num; i++) {
      Object *obj = objects->object + i;
      printf("  object[%d] label=%d prob=%.1f rect={x=%.1f y=%.1f w=%.1f h=%.1f}\n",
        i, obj->label, obj->prob, obj->rect.x, obj->rect.y, obj->rect.w, obj->rect.h);
    }
  } else {
    printf("yolox detect fail, err=%d\n", err);
  }

  objects_destroy(objects);
  return 0;
}
