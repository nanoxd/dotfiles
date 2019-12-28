# fish-await

Wait for background jobs to finish in [fish shell](https://fishshell.com).

> If you are on fish shell >=3.0 you can use `$last_pid` with [`wait`](https://fishshell.com/docs/current/commands.html#wait).

## Installation

With [Fisher](https://github.com/jorgebucaran/fisher)

```
fisher add fishpkg/fish-await
```

## Usage

Wait until the specified jobs are finished.

```fish
set -l pid

for code in $commands
    fish -c "$code" &
    set pid $pid (last_job_id --last)
end

await $pid
```

Customize spinners.

```fish
set -g await_spinners ◢ ◣ ◤ ◥
```

Customize interval between spinners.

```fish
set -g await_interval 0.1
```

## Dependencies

- [fishpkg/fish-last-job-id](https://github.com/fishpkg/fish-last-job-id) - Get the job id of all or only the last job

## License

Anyone is free to copy, modify, publish, use, compile, sell, or distribute this software, either in source code form or as a compiled binary, for any purpose, commercial or non-commercial, and by any means.

In jurisdictions that recognize copyright laws, the author or authors of this software dedicate any and all copyright interest in the software to the public domain. We make this dedication for the benefit of the public at large and to the detriment of our heirs and successors. We intend this dedication to be an overt act of relinquishment in perpetuity of all present and future rights to this software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
