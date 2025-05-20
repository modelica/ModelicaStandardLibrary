/* g2constructor.h - Module constructor and destructor helper header

  If G2_HAS_CONSTRUCTORS is true then the compiler support *both* constructors and
  destructors, in a sane way, including e.g. on library unload. If not you're on
  your own.

  Some compilers need #pragma to handle this, which does not work with macros,
  so the way you need to use this is (for constructors):

  #ifdef G2_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA
  #pragma G2_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(G2_FUNCNAME(my_constructor))
  #endif
  G2_DEFINE_CONSTRUCTOR(G2_FUNCNAME(my_constructor))
  static void G2_FUNCNAME(my_constructor)(void) {
   ...
  }

*/

#ifndef G2_CONSTRUCTOR_H_
#define G2_CONSTRUCTOR_H_

#ifndef G2_MODEL_PREFIX
#ifdef MODEL_IDENTIFIER
#define G2_MODEL_PREFIX MODEL_IDENTIFIER
#else
#define G2_MODEL_PREFIX
#endif
#endif

#define G2_CONCAT(a, b) a ## b
#define G2_CONCAT_(a, b) G2_CONCAT(a, b)
#define G2_FUNCNAME(name) G2_CONCAT_(G2_MODEL_PREFIX, name)

#if defined(__cplusplus)

#define G2_HAS_CONSTRUCTORS 1

#define G2_DEFINE_CONSTRUCTOR(_func) G2_CXX_CTOR(_func)
#define G2_DEFINE_DESTRUCTOR(_func) G2_CXX_DTOR(_func)

#define G2_CXX_CTOR(_func) \
  static void _func(void); \
  struct _func ## _wrapper_struct { _func ## _wrapper_struct() { _func(); } }; \
  static _func ## _wrapper_struct _func ## _wrapper;

#define G2_CXX_DTOR(_func) \
  static void _func(void); \
  struct _func ## _wrapper_struct2 { ~_func ## _wrapper_struct2() { _func(); } }; \
  static _func ## _wrapper_struct2 _func ## _wrapper2;

#elif (defined(__GNUC__) && (__GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 7))) || \
       defined(__clang__)

#define G2_HAS_CONSTRUCTORS 1

#define G2_DEFINE_CONSTRUCTOR(_func) static void __attribute__((constructor)) _func (void);
#define G2_DEFINE_DESTRUCTOR(_func) static void __attribute__((destructor)) _func (void);

#elif defined(_MSC_VER) && (_MSC_VER >= 1500)
/* Visual Studio 2008 and later has _pragma */

#define G2_HAS_CONSTRUCTORS 1

#ifdef _WIN64
#define G2_MSVC_SYMBOL_PREFIX ""
#else
#define G2_MSVC_SYMBOL_PREFIX "_"
#endif

#define G2_DEFINE_CONSTRUCTOR(_func) G2_MSVC_CTOR(_func, G2_MSVC_SYMBOL_PREFIX)
#define G2_DEFINE_DESTRUCTOR(_func) G2_MSVC_DTOR(_func, G2_MSVC_SYMBOL_PREFIX)

#define G2_MSVC_CTOR(_func, _sym_prefix) \
  static void _func(void); \
  extern int (* _array ## _func)(void); \
  int _func ## _wrapper(void) { _func(); return _array ## _func == NULL; } \
  __pragma(comment(linker,"/include:" _sym_prefix # _func "_wrapper")) \
  __pragma(section(".CRT$XCU",read)) \
  __declspec(allocate(".CRT$XCU")) int (* _array ## _func)(void) = _func ## _wrapper;

#define G2_MSVC_DTOR(_func, _sym_prefix) \
  static void _func(void); \
  extern int (* _array ## _func)(void); \
  int _func ## _constructor(void) { atexit (_func); return _array ## _func == NULL; } \
   __pragma(comment(linker,"/include:" _sym_prefix # _func "_constructor")) \
  __pragma(section(".CRT$XCU",read)) \
  __declspec(allocate(".CRT$XCU")) int (* _array ## _func)(void) = _func ## _constructor;

#elif defined(_MSC_VER) && (_MSC_VER >= 1400)

#define G2_HAS_CONSTRUCTORS 1

/* Pre Visual Studio 2008 must use #pragma section */
#define G2_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA 1
#define G2_DEFINE_DESTRUCTOR_NEEDS_PRAGMA 1

#define G2_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(_func) \
  section(".CRT$XCU",read)
#define G2_DEFINE_CONSTRUCTOR(_func) \
  static void _func(void); \
  static int _func ## _wrapper(void) { _func(); return 0; } \
  __declspec(allocate(".CRT$XCU")) static int (*p)(void) = _func ## _wrapper;

#define G2_DEFINE_DESTRUCTOR_PRAGMA_ARGS(_func) \
  section(".CRT$XCU",read)
#define G2_DEFINE_DESTRUCTOR(_func) \
  static void _func(void); \
  static int _func ## _constructor(void) { atexit (_func); return 0; } \
  __declspec(allocate(".CRT$XCU")) static int (* _array ## _func)(void) = _func ## _constructor;

#elif defined(__SUNPRO_C)

/* This is not tested, but I believe it should work, based on:
 * http://opensource.apple.com/source/OpenSSL098/OpenSSL098-35/src/fips/fips_premain.c
 */

#define G2_HAS_CONSTRUCTORS 1

#define G2_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA 1
#define G2_DEFINE_DESTRUCTOR_NEEDS_PRAGMA 1

#define G2_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(_func) \
  init(_func)
#define G2_DEFINE_CONSTRUCTOR(_func) \
  static void _func(void);

#define G2_DEFINE_DESTRUCTOR_PRAGMA_ARGS(_func) \
  fini(_func)
#define G2_DEFINE_DESTRUCTOR(_func) \
  static void _func(void);

#else

/* constructors not supported for this compiler */

#endif

#endif
