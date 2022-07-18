# go_router_demo

A go route navigation demo project.

# DL URL scheme
go_route_demo://autoroutedemo.page.link/<path>

## Nav to info screen
adb shell am start -a android.intent.action.VIEW \
-c android.intent.category.BROWSABLE \
-d 'go_route_demo://autoroutedemo.page.link/home/info'
