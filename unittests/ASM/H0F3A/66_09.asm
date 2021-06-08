%ifdef CONFIG
{
  "RegData": {
    "XMM0": ["0x0000000000000000", "0x8000000000000000"],
    "XMM1": ["0x0000000000000000", "0xbff0000000000000"],
    "XMM2": ["0x3ff0000000000000", "0x8000000000000000"],
    "XMM3": ["0x0000000000000000", "0x8000000000000000"],
    "XMM4": ["0x0000000000000000", "0x8000000000000000"],
    "XMM5": ["0x0000000000000000", "0xbff0000000000000"],
    "XMM6": ["0x3ff0000000000000", "0x8000000000000000"],
    "XMM7": ["0x0000000000000000", "0x8000000000000000"]
  }
}
%endif

lea rdx, [rel .data]

roundpd xmm0, [rdx + 8 * 0], 00000000b ; Nearest
roundpd xmm1, [rdx + 8 * 0], 00000001b ; -inf
roundpd xmm2, [rdx + 8 * 0], 00000010b ; +inf
roundpd xmm3, [rdx + 8 * 0], 00000011b ; truncate

; MXCSR
; Set to nearest
mov eax, 0x1F80
mov [rdx + 8 * 2], eax
ldmxcsr [rdx + 8 * 2]

roundpd xmm4, [rdx + 8 * 0], 00000100b

; Set to -inf
mov eax, 0x3F80
mov [rdx + 8 * 2], eax
ldmxcsr [rdx + 8 * 2]

roundpd xmm5, [rdx + 8 * 0], 00000100b

; Set to +inf
mov eax, 0x5F80
mov [rdx + 8 * 2], eax
ldmxcsr [rdx + 8 * 2]

roundpd xmm6, [rdx + 8 * 0], 00000100b

; Set to truncate
mov eax, 0x7F80
mov [rdx + 8 * 2], eax
ldmxcsr [rdx + 8 * 2]

roundpd xmm7, [rdx + 8 * 0], 00000100b

hlt

align 16
.data:
dq 0.5, -0.5
dq 0, 0
