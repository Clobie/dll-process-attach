/////////////////////////////////////////////////////////////////
// dllmain.cpp
/////////////////////////////////////////////////////////////////
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>

DWORD GetDllOffset(const char* DLL_NAME, int OFFSET)
{
	HMODULE hMod = GetModuleHandle(DLL_NAME);
	if(!hMod)
	{
		hMod = LoadLibrary(DLL_NAME);
		if(!hMod)
		{
			return 0;
		}
	}
	if(OFFSET < 0)
	{
		return (DWORD)GetProcAddress(hMod, (LPCSTR)(-OFFSET));
	}
	return (DWORD)hMod + OFFSET;
}

#define FPTR(CALL_TYPE, FUNC_NAME, PARAMETERS, DLL, OFFSET) typedef CALL_TYPE fp##FUNC_NAME##_t PARAMETERS; extern fp##FUNC_NAME##_t* fp##FUNC_NAME = (fp##FUNC_NAME##_t*)GetDllOffset(DLL, OFFSET);
FPTR(void __stdcall, PrintChat, (wchar_t* msg, int color), "D2Client.dll", 0x75EB0)
#undef FPTR

BOOL APIENTRY DllMain( HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved)
{
	int x = 0;
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		fpPrintChat(L"DLL Loaded!", 2);
		for(x = 0; x < 15; x++)
		{
			fpPrintChat(L"COLORS!", x);
		}
		return (BOOL)true;
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		return (BOOL)true;
		break;
	}
	return (BOOL)true;
}