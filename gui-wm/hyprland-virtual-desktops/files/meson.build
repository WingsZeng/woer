project(
  'virtual-desktops',
  'cpp',
  default_options: ['buildtype=release'],
)

cpp_compiler = meson.get_compiler('cpp')
if cpp_compiler.has_argument('-std=c++23')
  add_global_arguments('-std=c++23', language: 'cpp')
elif cpp_compiler.has_argument('-std=c++2b')
  add_global_arguments('-std=c++2b', language: 'cpp')
else
  error(
    'Could not configure current C++ compiler ('
    + cpp_compiler.get_id()
    + ' '
    + cpp_compiler.version()
    + ') with required C++ standard (C++23)',
  )
endif

add_project_arguments(
  '-DWLR_USE_UNSTABLE',
  '-fPIC',
  '--no-gnu-unique',
  language: 'cpp',
)

src = [
  'src/main.cpp',
  'src/sticky_apps.cpp',
  'src/utils.cpp',
  'src/VirtualDesk.cpp',
  'src/VirtualDeskManager.cpp',
]

if get_option('xwayland').disabled()
  add_project_arguments('-DNO_XWAYLAND', language: 'cpp')
endif

shared_module(
  meson.project_name(),
  src,
  dependencies: [
    dependency('hyprland', version: '>=0.41'),
    dependency('pixman-1'),
    dependency('libdrm'),
  ],
  include_directories: include_directories('include'),
  install: true,
)
