add_rules("mode.debug", "mode.release")

option("sdl")
    set_default(false)
    set_showmenu(true)
option_end()

option("example")
    set_default(false)
    set_showmenu(true)
option_end()

if is_plat("windows") then
    add_cxflags("/utf-8")
end

add_repositories("zeromake https://github.com/zeromake/xrepo.git")

if get_config("sdl") then
    add_requires("sdl2")
end

target("resize")
    set_kind("static")
    add_headerfiles("src/*.h", {prefixdir="resize"})
    add_files("src/*.c")
    if get_config("sdl") then
        add_defines("USE_SDL")
        add_packages("sdl2")
    end
target_end()

if get_config("example") then
    add_requires("sdl2_image")
    target("resize-demo")
        add_deps("resize")
        add_files("demo/resize.cpp")
        add_includedirs("src")
        add_defines("USE_SDL")
        add_packages("sdl2", "sdl2_image")
    target_end()
end
