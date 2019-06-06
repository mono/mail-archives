static char const data[] = "If you can see this, it's either fixed, or you got lucky and aren't running a malloc debugger.  Try changing the length of this string until you get a solid crash.";

extern "C" char const *foo() {
  return data;
}
