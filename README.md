# DLL Process Attach

## Overview

This repository contains a demonstration of how to create a DLL that attaches to a process, retrieves function offsets within a DLL, and executes a function when the DLL is loaded. The example uses the Windows API to achieve this functionality, showing how to load a library, get function addresses, and handle DLL process attach events.

## Functionality

### GetDllOffset Function

The `GetDllOffset` function retrieves the address of a function within a DLL given the DLL name and an offset. If the offset is negative, it uses `GetProcAddress` to get the function address. This allows the dynamic retrieval of function addresses at runtime, enabling the use of DLL functions without static linking.

### FPTR Macro

The `FPTR` macro is used to define a function pointer type and initialize it with the address retrieved by `GetDllOffset`. This macro simplifies the process of defining and initializing function pointers for use within the DLL.

### DllMain Function

The `DllMain` function is the entry point for the DLL. It handles different reasons for being called, specifically `DLL_PROCESS_ATTACH` in this example, and calls a function (`PrintChat`) when the DLL is loaded. This function prints a message indicating that the DLL has been loaded and demonstrates the use of function pointers to call DLL functions.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/Clobie/dll-process-attach.git
    cd dll-process-attach
    ```

2. Compile the DLL using your preferred C++ compiler (e.g., Visual Studio).

3. Load the compiled DLL into the target process to see the messages printed by the `PrintChat` function.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any inquiries or support, please contact [your email address].

---

Thank you for exploring this demonstration of DLL process attachment and function offset retrieval in Windows!
