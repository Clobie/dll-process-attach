# DLL Process Attach

## Overview

This repository contains a demonstration of how to create a DLL that attaches to a process, retrieves function offsets within a DLL, and executes a function when the DLL is loaded. The example uses the Windows API to achieve this functionality, showing how to load a library, get function addresses, and handle DLL process attach events.

## Functionality

### GetDllOffset Function

The `GetDllOffset` function retrieves the address of a function within a DLL given the DLL name and an offset. If the offset is negative, it uses `GetProcAddress` to get the function address. This allows the dynamic retrieval of function addresses at runtime, enabling the use of DLL functions without static linking.

### FPTR Macro

The `FPTR` macro is used to define a function pointer type and initialize it with the address retrieved by `GetDllOffset`. This macro simplifies the process of defining and initializing function pointers for use within the DLL.

### Example Usage Note

In this example, an outdated pointer address and target DLL were used to print a colored chat message inside Diablo 2. The specific address and DLL (`PrintChat` function in `D2Client.dll`) are no longer correct and are included here purely for illustrative purposes. Users will need to update the pointers and target DLLs according to their specific use case and target application.


### DllMain Function

The `DllMain` function is the entry point for the DLL. It handles different reasons for being called, specifically `DLL_PROCESS_ATTACH` in this example, and calls a function (`PrintChat`) when the DLL is loaded. This function prints a message indicating that the DLL has been loaded and demonstrates the use of function pointers to call DLL functions.
