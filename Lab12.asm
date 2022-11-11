.model SMALL
.DATA
        MATRIZ  DB 0,0,0,0
                DB 0,0,0,0
                DB 0,0,0,0
                DB 0,0,0,0
    msg db 10,'inisira a sua matriz 4x4:$'
    msg2 db 10, 'Matriz lida:$' 
    msg3 db 'Matriz transposta:$'
.stack 100h   

.CODE
pulalinha macro
mov ah,02
mov dl,10
int 21h
endm
MAIN PROC
MOV AX,@data
MOV DS,AX
MOV AH,09
    LEA DX,msg
    INT 21H
    call LE_MAT
    call SAIDA_MAT
    mov ah,02
    mov dl,10
    int 21h

    MOV AH,4ch
    int 21h

MAIN ENDP

LE_MAT PROC
MOV AH,01
XOR SI,SI
VOLTA:
CMP SI,16
JZ SAIDA
INT 21H
MOV MATRIZ[si],AL
INC SI
JMP VOLTA
SAIDA:
RET

LE_MAT ENDP

SAIDA_MAT PROC
    MOV AH,09
    LEA DX,msg2 
    INT 21H
    MOV AH,02
    MOV DL,10
    INT 21H
    XOR SI,SI 
lup:
    CMP SI,16
    JZ SAI
    CMP SI,4
    JZ CONTADOR
    CMP SI,8
    JZ CONTADOR 
    CMP SI,12
    JZ CONTADOR 
    JMP CONTADOR1
CONTADOR: 
    MOV DL,10
    INT 21H
CONTADOR1:
SAI2:
    MOV dl,MATRIZ[si]
    INT 21H
    MOV dl,32
    int 21h
    INC SI 
    JMP lup
SAI:
    pulalinha
    mov ah,09
    lea dx,msg3
    int 21h
    MOV AH,02
    XOR SI,SI 
LUP2:
    MOV DL,10
    INT 21H
    MOV dl,MATRIZ[si]
    INT 21H 
    MOV DL,32
    INT 21H
    MOV dl,MATRIZ[si+4]
    INT 21H 
    MOV DL,32
    INT 21H
    MOV dl,MATRIZ[si+8]
    int 21H
    MOV DL,32
    INT 21H
    MOV DL,MATRIZ[si+12]
    int 21h
    inc si 
    CMP si,4
    JNZ LUP2 
    
ret
SAIDA_MAT ENDP
end main
