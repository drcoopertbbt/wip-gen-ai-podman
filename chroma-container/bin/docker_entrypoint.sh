#!/bin/bash

export IS_PERSISTENT=1
uvicorn chromadb.app:app --workers 1 --host 0.0.0.0 --port 8000 --proxy-headers