# 1 "service/sys_svc/region/src/stack_gcc.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "service/sys_svc/region/src/stack_gcc.S"
@
# 35 "service/sys_svc/region/src/stack_gcc.S"
@
@
# 85 "service/sys_svc/region/src/stack_gcc.S"
@

@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@

        .global THUMB
        .global ARM
# 136 "service/sys_svc/region/src/stack_gcc.S"
@
@
@
@






@
@
@
   .global INT_GetCurrentSP
   .global INT_SwitchStackAndBranch
   .type INT_GetCurrentSP,STT_FUNC
   .type INT_SwitchStackAndBranch,STT_FUNC






@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@ int INT_GetCurrentSP(VOID)
@ {
INT_GetCurrentSP:

   MOV r0, sp @ get the current stack pointer

   BX lr @ Return to caller
.size INT_GetCurrentSP, .-INT_GetCurrentSP
@}

@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@
@ kal_uint32 INT_SwitchStackAndBranch(kal_uint32 new_stack, kal_func_ptr func, kal_uint32 argc, va_list argv)
@ {
INT_SwitchStackAndBranch:

   STMDB SP!, {R4-R7, LR}

   MOV R7, SP @ Backup original SP in R7
   MOV R6, R3 @ Load the poitner of argv
   MOV R5, R0 @ Backup new SP in R5
   SUBS R2, R2, #4 @ Check if need to copy stack?
   BLS skip_copy_stack

   ADD R6, R6, #16
   SUB R5, R0, R2, LSL #2 @ Reserve new stack to store arg4~n

copy_stack:
   LDRHI R4, [R6], #4 @ Copy arg4~n from argv to new stack
   STRHI R4, [R5], #4
   CMP R0, R5
   BHI copy_stack

   SUB R5, R0, R2, LSL #2 @ Change new stack pointer

skip_copy_stack:
   MOV R6, R1 @ Backup function pointer
   MOV R4, R3 @ Backup the pointer of argv;

   LDR R0, [R4] @ Setup arguments of procedure call
   LDR R1, [R4, #4]
   LDR R2, [R4, #8]
   LDR R3, [R4, #12]

   MOV SP, R5 @ Switch to new stack
   ADR lr, func_return
   BX R6 @ Procedure call
func_return:
   MOV SP, R7 @ Switch back to old stack

   LDMIA SP!, {R4-R7, PC}
.size INT_SwitchStackAndBranch, .-INT_SwitchStackAndBranch
@}


   .end
