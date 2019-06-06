#define WINVER 0x0500
#define _WIN32_WINNT 0x0500
#define _WIN32_IE 0x0501
#define UNICODE
#define _UNICODE
#include <windows.h>

#define STATUS_SUCCESS 0x00000000L
#define STATUS_INVALID_IMAGE_FORMAT 0xC000007BL

typedef HRESULT (STDAPICALLTYPE *MONOFIXUPCOREE)(HMODULE);

static HMODULE g_hMono;

STDAPI _CorValidateImage(PVOID *ImageBase, LPCWSTR FileName);
STDAPI stub_CorValidateImage(PVOID *ImageBase, LPCWSTR FileName);
static PVOID g_CorValidateImage = stub_CorValidateImage;

BOOL APIENTRY DllMain(HMODULE hModule, DWORD dwReason, LPVOID lpReserved)
{
	MONOFIXUPCOREE MonoFixupCorEE;
	PVOID new_CorValidateImage;

	switch (dwReason)
	{
	case DLL_PROCESS_ATTACH:
		DisableThreadLibraryCalls(hModule);
		g_hMono = LoadLibrary(L"C:\\Program Files\\Mono\\bin\\mono.dll");
		if (g_hMono == NULL)
			return FALSE;
		MonoFixupCorEE = (MONOFIXUPCOREE)GetProcAddress(g_hMono, "MonoFixupCorEE");
		if (MonoFixupCorEE == NULL)
			MonoFixupCorEE = (MONOFIXUPCOREE)GetProcAddress(g_hMono, "MonoFixupCorEE@4");
		if (MonoFixupCorEE == NULL || !SUCCEEDED(MonoFixupCorEE(hModule)))
			return FALSE;
		/* GetProcAddress on _CorValidateImage is called by ntdll.dll before DllMain in processes created from managed executables */
		new_CorValidateImage = GetProcAddress(hModule, "_CorValidateImage");
		if (new_CorValidateImage != &_CorValidateImage)
			g_CorValidateImage = new_CorValidateImage;
		break;
	case DLL_PROCESS_DETACH:
		if (g_hMono != NULL)
			FreeLibrary(g_hMono);
		break;
	}
	return TRUE;
}

BOOL STDMETHODCALLTYPE _CorDllMain(HINSTANCE hInst, DWORD dwReason, LPVOID lpReserved)
{
	switch (dwReason)
	{
	case DLL_PROCESS_ATTACH:
		DisableThreadLibraryCalls(hInst);
		break;
	}
	return TRUE;
}

__int32 STDMETHODCALLTYPE _CorExeMain()
{
	return 0;
}

STDAPI stub_CorValidateImage(PVOID *ImageBase, LPCWSTR FileName)
{
	return STATUS_SUCCESS;
}

__declspec(naked) STDAPI _CorValidateImage(PVOID *ImageBase, LPCWSTR FileName)
{
	__asm jmp g_CorValidateImage;
}

STDAPI_(VOID) _CorImageUnloading(PVOID ImageBase)
{
}

void STDMETHODCALLTYPE CorExitProcess(int exitCode)
{
	ExitProcess(exitCode);
}
