# klog.sh

[klog](https://github.com/kubernetes/klog) for bash (only bash for now).

Sourcing `klog.sh` will expose functions for INFO, WARNING, ERROR and FATAL.
Each level will have the following functions (where `X` is the capitalized level):

- `klog::X`: Simply print the arguments. The arguments will be joined together without spaces
- `klog::Xf`: Used in the same way as `printf`
- `klog::Xln`: Same as `klog::X`, but arguments will be separated by spaces.

The FATAL logger will print a stack trace and exit with 255.

All functions will log to `stderr` and treat newlines in their arguments correctly.
However they won't remove trailing newlines, like the actual klog functions would do.

Check out the `test.sh` file for some examples.
