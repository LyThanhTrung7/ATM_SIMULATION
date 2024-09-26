cmake_minimum_required(VERSION 3.16)

project(PROJECT_ATM VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appPROJECT_ATM
    main.cpp
    image.qrc
)

qt_add_qml_module(appPROJECT_ATM
    URI PROJECT_ATM
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES image.qrc
        SOURCES
        SOURCES login.h login.cpp
        SOURCES
        SOURCES infor_acc_user.h infor_acc_user.cpp
        SOURCES menu_atm.h menu_atm.cpp
        RESOURCES
        SOURCES history_transfer_user.h history_transfer_user.cpp

)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appPROJECT_ATM PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appPROJECT_ATM
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appPROJECT_ATM
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appPROJECT_ATM
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
