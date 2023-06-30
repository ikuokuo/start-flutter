#include "yolox.h"

#include <cstdlib>

struct Objects *objects_create() {
  return (Objects *) malloc(sizeof(struct Objects));
}

void objects_destroy(struct Objects *objects) {
  if (objects == NULL) return;

  if (objects->object != NULL) {
    free(objects->object);
    objects->object = NULL;
  }

  free(objects);
  objects = NULL;
}

yo_err_t objects_detect(const char *imagepath, struct Objects *objects) {
  int num = 5;
  Object *object = (Object *) malloc(num * sizeof(struct Object));

  for (int i = 0; i < num; i++) {
    Object *obj = object + i;

    obj->label = i;
    obj->prob = i;

    obj->rect.x = 0;
    obj->rect.y = 0;
    obj->rect.w = 0;
    obj->rect.h = 0;
  }

  objects->num = num;
  objects->object = object;
  return YO_OK;
}
