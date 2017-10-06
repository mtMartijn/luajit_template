#include <stdlib.h>

#include <luajit-2.1/lua.hpp>

int main(int argc, char* argv[]) {
  lua_State* L = luaL_newstate();
  luaL_openlibs(L);
  if(luaL_dofile(L, "main.lua"))
    printf("%s\n", lua_tostring(L, -1));

  return(EXIT_SUCCESS);
}
