#ifndef rdkafka_shim_h
#define rdkafka_shim_h
#ifdef __APPLE__
#ifdef __arm64__
#include "/opt/homebrew/include/librdkafka/rdkafka.h"
#else
#include "/usr/local/include/librdkafka/rdkafka.h"
#endif
#else
#include "/usr/include/librdkafka/rdkafka.h"
#endif
#endif
