# Qwen vLLM Lightning Deployment Image

OpenAI-compatible vLLM server for Lightning Deployment on port `8000`.

Default model:
- `Qwen/Qwen3-32B`
- served as `qwen3-32b-local`

Default endpoint shape:
- `GET /v1/models`
- `POST /v1/chat/completions`

Runtime env overrides:
- `MODEL_ID=Qwen/Qwen3-32B`
- `SERVED_MODEL_NAME=qwen3-32b-local`
- `MAX_MODEL_LEN=32768`
- `GPU_MEMORY_UTILIZATION=0.88`
- `DTYPE=bfloat16`

Image after GitHub Actions build:

```text
ghcr.io/cdbustamante28/qwen-vllm:latest
```

Lightning Deployment target:
- machine: `RTXP_6000` for Qwen3-32B
- port: `8000`
- min replicas: `0` if using autoscale/cold-start deployment

For a future 4x/8x H100 big-model lane, use a separate image/tag or command with tensor parallel, e.g. `Qwen/Qwen3-235B-A22B-Instruct-2507-FP8` and `--tensor-parallel-size <gpu_count>`.
