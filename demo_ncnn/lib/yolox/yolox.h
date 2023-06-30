#pragma once

#ifdef __cplusplus
extern "C" {
#endif

typedef int yo_err_t;

#define YO_OK        0
#define YO_ERROR    -1

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

struct Objects {
  int num;
  struct Object *object;
};

struct Objects *objects_create();
void objects_destroy(struct Objects *objects);

yo_err_t objects_detect(const char *imagepath, struct Objects *objects);

#ifdef __cplusplus
}
#endif
