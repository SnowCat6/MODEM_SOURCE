# 1 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
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




@ If assembled with TASM the variable {CONFIG} will be set to 16
@ If assembled with ARMASM the variable {CONFIG} will be set to 32
@ Set the variable THUMB to TRUE or false depending on whether the
@ file is being assembled with TASM or ARMASM.

@ GBLL THUMB
@ GBLL ARM
@ [ {CONFIG} = 16
.set THUMB, 0
.set ARM, 1

@ If assembling with TASM go into 32 bit mode as the Armulator will
@ start up the program in ARM state.

        .code 32
@ |
@THUMB SETL {FALSE}
@ARM SETL {TRUE}
@ ]


.equ I_BIT, 0x80
.equ F_BIT, 0x40
.equ INT_BIT, 0xC0


@
@
@

   .extern __rt_memcpy
   .extern INT_FIQ_Lisr
   .extern processing_irqlr
   .extern processing_fiqlr
   .extern isrC_Main
# 79 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
   @#include "nucleus_v2/inc/GCC/esal_ar_isr_defs.inc"
# 1 "service/nucleus_v2/inc/esal_ar_isr_defs_gcc.inc" 1
@***********************************************************************
@*
@* Copyright 1993-2006 Mentor Graphics Corporation
@* All Rights Reserved.
@*
@* THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS
@* THE PROPERTY OF MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS
@* SUBJECT TO LICENSE TERMS.
@*
@***********************************************************************

@***********************************************************************
@*
@* FILE NAME
@*
@* esal_ar_isr_defs.inc
@*
@* COMPONENT
@*
@* ESAL - Embedded Software Abstraction Layer
@*
@* DESCRIPTION
@*
@* This file contains the architecture specific definitions,
@* constants, etc, related to interrupt servicing
@*
@* DATA STRUCTURES
@*
@* None
@*
@* DEPENDENCIES
@*
@* None
@*
@*============================================================================
@* HISTORY
@* Below this line, this part is controlled by PVCS VM. DO NOT MODIFY!!
@*------------------------------------------------------------------------------
@* $Revision$
@* $Modtime$
@* $Log$
@*
@* 03 19 2014 hc.yang
@* [MOLY00059827] [System Service][MOLY Kernel Internal Request]Add MTK header to each Nucleus Plus file for check-in history
@* .
@*
@*------------------------------------------------------------------------------
@* Upper this line, this part is controlled by PVCS VM. DO NOT MODIFY!!
@*============================================================================
@***********************************************************************

@ Define to allow conditional assembling of lowlevel ISR hook.
@ Setting this to TRUE will allow a low-level hook to be executed in the
@ interrupt handlers

@ GBLL ESAL_AR_ISR_HOOK_ENABLED
@ESAL_AR_ISR_HOOK_ENABLED SETL {FALSE}
.equ ESAL_AR_ISR_HOOK_ENABLED, 0

@ Define to allow conditional assembling of reset vector type (branch versus load).
@ Setting this to TRUE will force the reset vector to utilize a branch instruction.
@ This is necessary for certain processors that re-map memory and require a PC
@ relative jump to the entry point versus a full 32-bit address (before remapping memory).

@ GBLL ESAL_AR_ISR_RESET_BRANCH
@ESAL_AR_ISR_RESET_BRANCH SETL {FALSE}
.equ ESAL_AR_ISR_RESET_BRANCH, 0

@ Define to allow conditional compilation for ARM7TDMI processor. Setting this
@ to TRUE will include necessary low-level interrupt handling code specific to
@ the ARM7TDMI and its pipeline architecture.

@ GBLL ESAL_AR_ISR_CPU7TDMI
@ESAL_AR_ISR_CPU7TDMI SETL {CPU} = "ARM7TDMI"

@ Define architecture interrupt handling constants,
@ register addresses, initialization values, structures, etc.

@ Define constants for CPSR interrupt / mode bits



.equ ESAL_AR_ISR_CPSR_MODE_MASK, 0x0000001F
.equ ESAL_AR_ISR_CPSR_SYS_MODE , 0x0000001F
.equ ESAL_AR_ISR_CPSR_SUP_MODE , 0x00000013
.equ ESAL_AR_ISR_CPSR_IRQ_MODE , 0x00000012
.equ ESAL_AR_ISR_CPSR_FIQ_MODE , 0x00000011
.equ ESAL_AR_ISR_CPSR_UND_MODE , 0x0000001B
.equ ESAL_AR_ISR_CPSR_ABT_MODE , 0x00000017
.equ ESAL_AR_ISR_CPSR_IRQ_BIT , 0x00000080
.equ ESAL_AR_ISR_CPSR_FIQ_BIT , 0x00000040

@ Define architecture ESAL interrupt vector IDs
@ These IDs match up with architecture interrupts.
@ Values correspond to the index of entries in ESAL_GE_ISR_Interrupt_Handler[].
@ Names are of the form ESAL_AR_<Name>_INT_VECTOR_ID, where <Name> comes
@ directly from the hardware documentation.

@ESAL_AR_IRQ_INT_VECTOR_ID EQU 0
@ESAL_AR_FIQ_INT_VECTOR_ID EQU 1

.equ ESAL_AR_IRQ_INT_VECTOR_ID, 0
.equ ESAL_AR_FIQ_INT_VECTOR_ID, 1


@ Define architecture ESAL exception vector IDs
@ These IDs match up with architecture exceptions.
@ Values correspond to the index of entries in ESAL_GE_ISR_Exception_Handler[].
@ Names are of the form ESAL_AR_<Name>_EXCEPT_VECTOR_ID, where <Name> comes
@ directly from the hardware documentation.

@ESAL_AR_UNDEF_EXCEPT_VECTOR_ID EQU 0
@ESAL_AR_SWI_EXCEPT_VECTOR_ID EQU 1
@ESAL_AR_PREFETCH_EXCEPT_VECTOR_ID EQU 2
@ESAL_AR_DATA_EXCEPT_VECTOR_ID EQU 3

.equ ESAL_AR_UNDEF_EXCEPT_VECTOR_ID,0
.equ ESAL_AR_SWI_EXCEPT_VECTOR_ID,1
.equ ESAL_AR_PREFETCH_EXCEPT_VECTOR_ID,2
.equ ESAL_AR_DATA_EXCEPT_VECTOR_ID,3

@ END
# 81 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S" 2
   @#include "nucleus_v2/inc/GCC/esal_ar_stk_defs.inc"
# 1 "service/nucleus_v2/inc/esal_ar_stk_defs_gcc.inc" 1
@***********************************************************************
@*
@* Copyright 1993-2006 Mentor Graphics Corporation
@* All Rights Reserved.
@*
@* THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS
@* THE PROPERTY OF MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS
@* SUBJECT TO LICENSE TERMS.
@*
@***********************************************************************

@***********************************************************************
@*
@* FILE NAME
@*
@* esal_ar_stk_defs.inc
@*
@* COMPONENT
@*
@* ESAL - Embedded Software Abstraction Layer
@*
@* DESCRIPTION
@*
@* This file contains the architecture specific definitions,
@* constants, etc, related to stacks
@*
@* DATA STRUCTURES
@*
@* None
@*
@* DEPENDENCIES
@*
@* None
@*
@*============================================================================
@* HISTORY
@* Below this line, this part is controlled by PVCS VM. DO NOT MODIFY!!
@*------------------------------------------------------------------------------
@* $Revision$
@* $Modtime$
@* $Log$
@*
@* 03 19 2014 hc.yang
@* [MOLY00059827] [System Service][MOLY Kernel Internal Request]Add MTK header to each Nucleus Plus file for check-in history
@* .
@*
@*------------------------------------------------------------------------------
@* Upper this line, this part is controlled by PVCS VM. DO NOT MODIFY!!
@*============================================================================
@***********************************************************************

@ Define if floating point registers will be saved during context switches
@ NOTE: The C define must be changed in esal_ar_stk_defs.h to
@ match this define.
@ NOTE: This define will dictate what registers are contained
@ within solicited (TS) and unsolicited (AR) stack frames.

@ GBLL ESAL_AR_STK_FPU_SUPPORT
@ESAL_AR_STK_FPU_SUPPORT SETL {FALSE}



@ Startup / initialization stack size in bytes

@ESAL_AR_STK_STARTUP_STACK_SIZE EQU 1024
.equ ESAL_AR_STK_STARTUP_STACK_SIZE,1024
# 89 "service/nucleus_v2/inc/esal_ar_stk_defs_gcc.inc"
@ Size, in bytes, of max architecture stack frames (without floating point)
.equ ESAL_AR_STK_MAX_FRAME_SIZE , 68
@ Size, in bytes, of min architecture stack frames
.equ ESAL_AR_STK_MIN_FRAME_SIZE , 32

@ Offsets, in bytes, of registers in minimum stack frame

.equ ESAL_AR_STK_MIN_LR_OFFSET , 20
.equ ESAL_AR_STK_MIN_PC_OFFSET , 24
.equ ESAL_AR_STK_MIN_SPSR_OFFSET , 28







@ Offset, in bytes, of LR in full stack frame



.equ ESAL_AR_STK_LR_OFFSET , (ESAL_AR_STK_MAX_FRAME_SIZE-12)






@ Based on ESAL_TS_REQ_STK_ALIGNMENT in esal_ts_cfg.h

@ESAL_AR_STK_ALIGNMENT_MASK EQU 0x00000007
.equ ESAL_AR_STK_ALIGNMENT_MASK,0x00000007

@ Offsets, in bytes, of registers on temp stack


.equ ESAL_AR_STK_TMP_R0_OFFSET,0
.equ ESAL_AR_STK_TMP_SPSR_OFFSET,4
.equ ESAL_AR_STK_TMP_LR_OFFSET,8


@ VFP enable value

.equ ESAL_AR_STK_VFP_ENABLE,0x40000000

    .macro ESAL_AR_STK_FPU_SAVE
# 152 "service/nucleus_v2/inc/esal_ar_stk_defs_gcc.inc"
    .endm


    .macro ESAL_AR_STK_FPU_RESTORE
# 170 "service/nucleus_v2/inc/esal_ar_stk_defs_gcc.inc"
    .endm


@***********************************************************************
@* ESAL_AR_STK_MIN_INT_SAVE
@*
@* Save minimal amount of registers required for handling interrupts.
@* ESAL_AR_STK_Unsolicited_Switch() will save the rest.
@***********************************************************************

    .macro ESAL_AR_STK_MIN_INT_SAVE

    CPSID aif, #ESAL_AR_ISR_CPSR_SYS_MODE
    STMDB sp!,{r0-r3, r12, r14}
# 231 "service/nucleus_v2/inc/esal_ar_stk_defs_gcc.inc"
    ESAL_AR_STK_FPU_SAVE

    .endm


@***********************************************************************
@* ESAL_AR_STK_MIN_INT_RESTORE
@*
@* Restore minimal amount of registers required for handling interrupts.
@***********************************************************************

    .macro ESAL_AR_STK_MIN_INT_RESTORE


    MOV sp,r0
    ESAL_AR_STK_FPU_RESTORE
    @ Restore minimal registers
    LDMIA sp!,{r0-r3, r12, r14}
    RFEIA sp!
# 288 "service/nucleus_v2/inc/esal_ar_stk_defs_gcc.inc"
    .endm


@***********************************************************************
@* ESAL_AR_STK_MIN_EXCEPT_SAVE
@*
@* Save minimal amount of registers required for handling exceptions.
@***********************************************************************

    .macro ESAL_AR_STK_MIN_EXCEPT_SAVE

    @ Save exception return address on stack

    STR lr,[sp,#-4]!

    @ No lr to save, so skip it on stack

    SUB sp,sp,#4

    @ Put spsr in r14 and save remaining
    @ minimal context on stack

    MRS r14,spsr
    STMDB sp!,{r0-r3, r12, r14}

    .endm


@***********************************************************************
@* ESAL_AR_STK_MIN_EXCEPT_RESTORE
@*
@* Restore minimal amount of registers required for handling exceptions.
@***********************************************************************

    .macro ESAL_AR_STK_MIN_EXCEPT_RESTORE

    @ Restore min stack registers

    LDMIA sp!,{r0-r3, r12, r14}

    @ Restore SPSR

    MSR SPSR_cxsf,r14

    @ Skip lr on stack

    ADD sp,sp,#4

    @ Return to point of interrupt
    @ NOTE: {pc}^ also restores the CPSR from the SPSR

    LDMIA sp!,{pc}^

    .endm

@ END
# 83 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S" 2
# 92 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
   .extern ESAL_AR_STK_Unsolicited_Switch
   .extern ESAL_GE_ISR_OS_Entry
   .extern ESAL_GE_ISR_OS_Nested_Entry
   .extern ESAL_GE_ISR_Executing
   .extern ESAL_GE_STK_System_SP
   .extern ESAL_GE_STK_Unsol_Switch_Req
   .extern ESAL_GE_STK_System_SP
   .extern No_Context_Switch
# 130 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
@
@
@

   .global INT_FIQ_Parse
   .global INT_IRQ_Parse

   .global DisableIRQ
   .global ReEnableIRQ
   .global LockIRQ
   .global RestoreIRQ
   .global CheckIRQLock
# 156 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
FIQ_RETURN_PTR:
   .word processing_fiqlr

;
@}
# 242 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
_INT_FIQ_Lisr:
   .word INT_FIQ_Lisr
INT_FIQ_Parse:

    @ Adjust lr to interrupt address

    SUB lr,lr,#4

    @ Save minimum architecture registers to stack for interrupt

    ESAL_AR_STK_MIN_INT_SAVE

    @ stack pointer in r1 (2nd parameter)

    MOV r1,sp

    BL _INT_FIQ_Lisr

    @ Never Come here
FIQ_LOOP_FOREVER:
    B FIQ_LOOP_FOREVER

ESAL_AR_ISR_Nested_FIQ_Restore:

    @ Put the stack pointer in r0

    MOV r0,sp

    @ Restore minimum registers from stack and return from interrupt

    ESAL_AR_STK_MIN_INT_RESTORE
.size INT_FIQ_Parse, .-INT_FIQ_Parse
# 339 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
   .code 32

   .section "INTSRAM_ROCODE", "ax"




@
@}
# 362 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
ESAL_AR_ISR_Executing:
    .word ESAL_GE_ISR_Executing
ESAL_AR_ISR_System_SP:
    .word ESAL_GE_STK_System_SP
ESAL_AR_ISR_OS_Entry:
    .word ESAL_GE_ISR_OS_Entry
ESAL_AR_ISR_OS_Nested_Entry:
    .word ESAL_GE_ISR_OS_Nested_Entry
ESAL_AR_ISR_Unsol_Switch_Req:
    .word ESAL_GE_STK_Unsol_Switch_Req
NO_CONTEXT_SWITCH_LOGGING:
    .word No_Context_Switch






INT_IRQ_Parse:


    STMIA sp!, {r1}
    MRS r1, SPSR
    TST r1, #ESAL_AR_ISR_CPSR_IRQ_BIT
    LDMDB sp!, {r1}
    SUBNES pc,lr,#4

    @ Adjust lr to interrupt address

    SUB lr,lr,#4

    @ Save minimum architecture registers to stack for interrupt

    ESAL_AR_STK_MIN_INT_SAVE





    LDR a1,=processing_irqlr
    LDR a2, [sp,#ESAL_AR_STK_MIN_PC_OFFSET]
    STR a2, [a1] @ Save IRQ`s return address to global variable.
# 413 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
    @ Put ESAL interrupt ID in r0 (1st parameter)

@ MOV r0,#ESAL_AR_IRQ_INT_VECTOR_ID
# 436 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
    @ stack pointer in r1 (2nd parameter)

    MOV r1,sp

    @ Check if this interrupt occurred during execution of
    @ another interrupt (nested)

    LDR r2,ESAL_AR_ISR_Executing
    LDR r2,[r2]
    CMP r2,#0

    @ Switch stack if first interrupt (not nested)

    LDREQ sp,ESAL_AR_ISR_System_SP
    LDREQ sp,[sp]

    @ Get address of OS entry for correct interrupt handler
    @ (nested or non-nested)

    LDREQ r2,ESAL_AR_ISR_OS_Entry
    LDRNE r2,ESAL_AR_ISR_OS_Nested_Entry
    LDR r2,[r2]

    @ Get return address and transfer
    @ control to OS entry for interrupt handling

    ADRNE lr,ESAL_AR_ISR_Nested_IRQ_Restore
    MOVEQ lr,pc
    BX r2

    @ Check if context switch is required as a result of
    @ the interrupt service routine

    LDR r2,ESAL_AR_ISR_Unsol_Switch_Req
    LDR r2,[r2]
    CMP r2,#0

    @ Perform context switch if required

    BNE ESAL_AR_STK_Unsolicited_Switch

    @ No context switch required, restore minimal context and
    @ return to point of interrupt

    @ Get system stack pointer in r0

    LDR r0,[r0]

    @ Save the r0 to the stack
    STMDB sp!, {r0}
    LDR r0,NO_CONTEXT_SWITCH_LOGGING
    BLX r0
# 498 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
    @ Restore r0 from the stack
    LDMIA sp!, {r0}

    @ Restore minimum registers from stack and return from interrupt

    ESAL_AR_STK_MIN_INT_RESTORE

ESAL_AR_ISR_Nested_IRQ_Restore:

    @ Put the stack pointer in r0

    MOV r0,sp

    @ Restore minimum registers from stack and return from interrupt

    ESAL_AR_STK_MIN_INT_RESTORE
.size INT_IRQ_Parse, .-INT_IRQ_Parse
# 612 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
@ INT DisableIRQ(VOID)
@ {
.type DisableIRQ, %function
DisableIRQ:
   STMDB SP!,{R1}
   MRS R0,CPSR
   MOV R1,R0

   ORR R0,R0,#I_BIT
   MSR CPSR_c, R0
   MOV R0,R1
   LDMIA SP!,{R1}

    BX lr @ Return to caller
.size DisableIRQ, .-DisableIRQ
@}
# 648 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
@ VOID ReEnableIRQ( VOID)
@ {
.type ReEnableIRQ, %function
ReEnableIRQ:
   STMDB SP!, {R0}
   MRS R0, CPSR
   BIC R0, R0, #I_BIT
   MSR CPSR_c, R0
   LDMIA SP!, {R0}

   BX lr @ Return to caller
.size ReEnableIRQ, .-ReEnableIRQ
@}
# 681 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
@ INT LockIRQ(VOID)
@ {
.type LockIRQ, %function
LockIRQ:
   STMDB SP!,{R1}
   MRS R0,CPSR
   MOV R1,R0

   ORR R0,R0,#INT_BIT
   MSR CPSR_c, R0
   MOV R0,R1
   LDMIA SP!,{R1}

   BX lr @ Return to caller
.size LockIRQ, .-LockIRQ
@}
# 718 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
@ VOID RestoreIRQ(INT)
@ {
.type RestoreIRQ, %function
RestoreIRQ:
   STMDB SP!,{R1,R2}
   MRS R1,CPSR
   AND R2,R0,#INT_BIT
   BIC R1,R1,#INT_BIT
   ORR R0,R1,R2
   MSR CPSR_c,R0
   LDMIA SP!,{R1,R2}

   BX lr @ Return to caller
.size RestoreIRQ, .-RestoreIRQ
@}
# 748 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
@ UINT CheckIRQLock(VOID)
@ {
.type CheckIRQLock, %function
CheckIRQLock:
   MRS R0,CPSR
   AND R0,R0,#INT_BIT

   BX lr @ Return to caller
.size CheckIRQLock, .-CheckIRQLock
@}
# 787 "driver/devdrv/cirq_v2/src/GCC/irq_gcc.S"
   .end
