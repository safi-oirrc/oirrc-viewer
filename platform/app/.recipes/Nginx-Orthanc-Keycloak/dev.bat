@echo off
REM Helper script to manage OHIF development environment on Windows

if "%1"=="" goto usage
if "%1"=="start" goto start
if "%1"=="start-bg" goto start-bg
if "%1"=="stop" goto stop
if "%1"=="restart" goto restart
if "%1"=="rebuild" goto rebuild
if "%1"=="logs" goto logs
if "%1"=="clean" goto clean
if "%1"=="prod" goto prod
goto usage

:start
echo Starting OHIF Viewer in development mode with hot reloading...
docker-compose -f docker-compose.dev.yml up
goto end

:start-bg
echo Starting OHIF Viewer in development mode (background)...
docker-compose -f docker-compose.dev.yml up -d
goto end

:stop
echo Stopping OHIF Viewer development environment...
docker-compose -f docker-compose.dev.yml down
goto end

:restart
echo Restarting OHIF Viewer...
docker-compose -f docker-compose.dev.yml restart oirrc_viewer
goto end

:rebuild
echo Rebuilding OHIF Viewer from scratch...
docker-compose -f docker-compose.dev.yml down
docker-compose -f docker-compose.dev.yml build --no-cache
docker-compose -f docker-compose.dev.yml up
goto end

:logs
docker-compose -f docker-compose.dev.yml logs -f oirrc_viewer
goto end

:clean
echo Cleaning up OHIF Viewer environment...
docker-compose -f docker-compose.dev.yml down -v
goto end

:prod
echo Starting OHIF Viewer in production mode...
docker-compose up --build
goto end

:usage
echo OHIF Viewer Development Helper
echo.
echo Usage: %0 {start^|start-bg^|stop^|restart^|rebuild^|logs^|clean^|prod}
echo.
echo   start     - Start in development mode (with logs)
echo   start-bg  - Start in development mode (background)
echo   stop      - Stop the development environment
echo   restart   - Restart the viewer container
echo   rebuild   - Clean rebuild from scratch
echo   logs      - View viewer logs
echo   clean     - Remove all containers and volumes
echo   prod      - Start in production mode
echo.
goto end

:end
