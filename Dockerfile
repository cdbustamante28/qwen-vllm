# vLLM OpenAI-compatible server for Lightning Deployments.
# Build args let us reuse this for Qwen3-32B now and Qwen3-235B later.
FROM vllm/vllm-openai:latest

ENV HF_HOME=/models/huggingface \
    VLLM_HOST=0.0.0.0 \
    VLLM_PORT=8000 \
    MODEL_ID=Qwen/Qwen3-32B \
    SERVED_MODEL_NAME=qwen3-32b-local \
    MAX_MODEL_LEN=32768 \
    GPU_MEMORY_UTILIZATION=0.88 \
    DTYPE=bfloat16

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=10s --start-period=300s --retries=10 \
  CMD python3 -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/v1/models', timeout=5).read()" || exit 1

# The upstream vllm/vllm-openai image defines an ENTRYPOINT. Clear it so
# Lightning runs exactly the shell command below rather than appending CMD as
# arguments to the upstream entrypoint.
ENTRYPOINT []
CMD ["/bin/bash", "-lc", "python3 -m vllm.entrypoints.openai.api_server --host ${VLLM_HOST} --port ${VLLM_PORT} --model ${MODEL_ID} --served-model-name ${SERVED_MODEL_NAME} --dtype ${DTYPE} --max-model-len ${MAX_MODEL_LEN} --gpu-memory-utilization ${GPU_MEMORY_UTILIZATION} --trust-remote-code"]
