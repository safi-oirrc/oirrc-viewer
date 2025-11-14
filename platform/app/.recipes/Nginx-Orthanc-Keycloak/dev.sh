#!/bin/bash

# Helper script to manage OHIF development environment

case "$1" in
  start)
    echo "Starting OHIF Viewer in development mode with hot reloading..."
    docker-compose -f docker-compose.dev.yml up
    ;;
  start-bg)
    echo "Starting OHIF Viewer in development mode (background)..."
    docker-compose -f docker-compose.dev.yml up -d
    ;;
  stop)
    echo "Stopping OHIF Viewer development environment..."
    docker-compose -f docker-compose.dev.yml down
    ;;
  restart)
    echo "Restarting OHIF Viewer..."
    docker-compose -f docker-compose.dev.yml restart oirrc_viewer
    ;;
  rebuild)
    echo "Rebuilding OHIF Viewer from scratch..."
    docker-compose -f docker-compose.dev.yml down
    docker-compose -f docker-compose.dev.yml build --no-cache
    docker-compose -f docker-compose.dev.yml up
    ;;
  logs)
    docker-compose -f docker-compose.dev.yml logs -f oirrc_viewer
    ;;
  clean)
    echo "Cleaning up OHIF Viewer environment..."
    docker-compose -f docker-compose.dev.yml down -v
    ;;
  prod)
    echo "Starting OHIF Viewer in production mode..."
    docker-compose up --build
    ;;
  *)
    echo "OHIF Viewer Development Helper"
    echo ""
    echo "Usage: $0 {start|start-bg|stop|restart|rebuild|logs|clean|prod}"
    echo ""
    echo "  start     - Start in development mode (with logs)"
    echo "  start-bg  - Start in development mode (background)"
    echo "  stop      - Stop the development environment"
    echo "  restart   - Restart the viewer container"
    echo "  rebuild   - Clean rebuild from scratch"
    echo "  logs      - View viewer logs"
    echo "  clean     - Remove all containers and volumes"
    echo "  prod      - Start in production mode"
    echo ""
    exit 1
    ;;
esac
