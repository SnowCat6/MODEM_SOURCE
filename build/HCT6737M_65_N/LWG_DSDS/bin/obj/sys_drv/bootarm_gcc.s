# 1 "driver/sys_drv/init/src/bootarm_gcc.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "driver/sys_drv/init/src/bootarm_gcc.S"
# 516 "driver/sys_drv/init/src/bootarm_gcc.S"
# 1 "interface/driver/sys_drv/asm_def.h" 1
# 517 "driver/sys_drv/init/src/bootarm_gcc.S" 2

   .thumb
   .syntax unified

# 1 "./build/HCT6737M_65_N/LWG_DSDS/header_temp/reg_base.h" 1
# 560 "./build/HCT6737M_65_N/LWG_DSDS/header_temp/reg_base.h"
# 1 "driver/regbase/inc/reg_base_mt6735_md1.h" 1
# 561 "./build/HCT6737M_65_N/LWG_DSDS/header_temp/reg_base.h" 2
# 522 "driver/sys_drv/init/src/bootarm_gcc.S" 2
# 1 "driver/sys_drv/init/inc/bootarm.h" 1
# 523 "driver/sys_drv/init/src/bootarm_gcc.S" 2



# 1 "driver/sys_drv/init/inc/bootarm_var_gcc.inc" 1
# 527 "driver/sys_drv/init/src/bootarm_gcc.S" 2




.macro INT_TRC trace_id

    LDR a1, =Init_Magic_Num
    LDR a1, [a1]
    MOV a2, #\trace_id
    BL INC_TRC

.endm

   .section ".rodata"
   .align 3



   .global LDR_PC_Initialize
LDR_PC_Initialize:
   .word 0xE59FF018 @ ldr pc,INT_Table





    .data
    .align 3

    .global INT_Loaded_Flag
INT_Loaded_Flag:
    .word 0x00000000


   .align 5
ABT_Stack_Pool:
   .ascii "STACKEND"
   .space 128 -8

   .align 5
UND_Stack_Pool:
   .ascii "STACKEND"
   .space 128 -8

   .align 5
FIQ_Stack_Pool:
   .ascii "STACKEND"
   .space 128 -8
# 593 "driver/sys_drv/init/src/bootarm_gcc.S"
   .align 5
   .global EX_Stack_Pool
EX_Stack_Pool:
   .ascii "STACKEND"
   .space 4096 -8


   .section "INTSRAM_RW", "w", %progbits





   .align 5
IRQ_Stack_Pool:
   .ascii "STACKEND"
   .space 168 -8


   .global SYS_Stack_Pool
   .align 5
SYS_Stack_Pool:
   .ascii "STACKEND"



   .space 8192 -8



   .align 5
EX_SYS_Stack_Pool:
   .ascii "STACKEND"
   .space 256 -8

Abnormal_info_Pool:
   .space 16

   .section "INT_VECTOR_CODE", "ax"
   .align 2






   .global BOOT_EX_Stack_End







@VOID *INT_Vectors[NU_MAX_VECTORS];

   .thumb
   .syntax unified
   .thumb_func
   .global INT_Vectors
INT_Vectors:



      LDR pc,INT_Table_Local

   LDR pc,(INT_Table_Local + 4)
   LDR pc,(INT_Table_Local + 8)
   LDR pc,(INT_Table_Local + 12)
   LDR pc,(INT_Table_Local + 16)
   LDR pc,(INT_Table_Local + 20)
   LDR pc,(INT_Table_Local + 24)
   LDR pc,(INT_Table_Local + 28)
.size INT_Vectors, .-INT_Vectors

   .global INT_Table

INT_Table:
INT_Table_Local:
INT_Initialize_Addr: .word INT_Initialize
Undef_Instr_Addr: .word Undef_Instr_ISR
SWI_Addr: .word SWI_ISR
Prefetch_Abort_Addr: .word Prefetch_Abort_ISR
Data_Abort_Addr: .word Data_Abort_ISR
Undefined_Addr: .word 0 @ NO LONGER USED
IRQ_Handler_Addr: .word INT_IRQ_Parse
FIQ_Handler_Addr: .word INT_FIQ_Parse

INT_Table_End:

    .text
    .align 3

# 1 "driver/sys_drv/init/inc/bootarm_gcc.inc" 1
# 687 "driver/sys_drv/init/src/bootarm_gcc.S" 2




ROM_Base_Ptr:
   .word Image$$ROM$$Base

INT_Table_End_PTR:
   .word INT_Table_End
# 711 "driver/sys_drv/init/src/bootarm_gcc.S"
Loaded_Flag:
   .word INT_Loaded_Flag






@ Nucleus Plus2: rename TCD_System_Stack to ESAL_GE_STK_System_SP
@ and remove TCT_System_Limit
System_Stack:
   .word ESAL_GE_STK_System_SP
# 739 "driver/sys_drv/init/src/bootarm_gcc.S"
BOOT_IRQ_Stack_End:
   .word IRQ_Stack_Pool+168 -4

BOOT_FIQ_Stack_End:
   .word FIQ_Stack_Pool+128 -4

BOOT_ABT_Stack_End:
   .word ABT_Stack_Pool+128 -4

BOOT_UND_Stack_End:
   .word UND_Stack_Pool+128 -4

   .global BOOT_SYS_Stack_End
BOOT_SYS_Stack_End:
   .word SYS_Stack_Pool+8192 -4

BOOT_SYS_Stack_End_Local:



   .word SYS_Stack_Pool+8192 -4



BOOT_SYS_Stack:
   .word SYS_Stack_Pool

BOOT_EX_Stack_End:
   .word EX_Stack_Pool+4096 -0x44

   .global BOOT_EX_SYS_Stack_End
BOOT_EX_SYS_Stack_End:
   .word EX_SYS_Stack_Pool+256 -4






RAND_NUM_SEED_PTR:
   .word rand_num_seed

ECO_VERSION_PTR:
   .word eco_version

ABN_RST_PTR:
   .word Abnormal_info_Pool


.global Init_Magic_Num
Init_Magic_Num:
    .word 0x30305F49

@ void INC_TRC(kal_uint32 trace_log1, kal_uint32 trace_log2)
@ {

.global INC_TRC
.type INC_TRC, %function

INC_TRC:
    MOV r7, lr

    LDR a3, =g_EMM_BOOTTRC_ADDR





    LDR a3, [a3]
    STR a1, [a3]
    STR a2, [a3, #4]


    BX lr
.size INC_TRC, .-INC_TRC
@ }


@ void DENALI_1_SRAM_DELSEL_WORKAROUND()
@ {
.global DENALI_1_SRAM_DELSEL_WORKAROUND
.type DENALI_1_SRAM_DELSEL_WORKAROUND, %function

DENALI_1_SRAM_DELSEL_WORKAROUND:

    LDR a1,=0x80000008
    LDRH a1,[a1]
    LDR a2,=0x6735
    CMP a1,a2
    BNE DENALI_1_SRAM_DELSEL_WORKAROUND_END
    LDR a1,=0x8000000C
    LDRH a1,[a1]
    LDR a2,=0x8A00
    CMP a1,a2
    BNE DENALI_1_SRAM_DELSEL_WORKAROUND_END

    LDR a1,=0x80110040
    LDR a2,=0x000a000a
    STR a2,[a1]
    LDR a1,=0x80110048
    LDR a2,=0x000a000a
    STR a2,[a1]
    LDR a1,=0x8011004C
    LDR a2,=0x000a000a
    STR a2,[a1]
    DSB
DENALI_1_SRAM_DELSEL_WORKAROUND_END:
    BX lr
.size DENALI_1_SRAM_DELSEL_WORKAROUND, .-DENALI_1_SRAM_DELSEL_WORKAROUND
@ }
# 888 "driver/sys_drv/init/src/bootarm_gcc.S"
@VOID INT_Initialize(void)
@{

   .global INT_Initialize
.type INT_Initialize, %function
INT_Initialize:
@
   MRS a1,CPSR @ Pickup current CPSR
   BIC a1,a1,#0x3F @ Clear the mode bits
   ORR a1,a1,#0x3f @ Set the kernel mode bits
   ORR a1,a1,#0xC0 @ Insure IRQ/FIQ interrupts are
                                            @ locked out
   MSR CPSR_cxsf,a1 @ Setup the new CPSR
# 1038 "driver/sys_drv/init/src/bootarm_gcc.S"
   @ Restart watchdog in order to avoid the unexpected wdt reset when booting
   LDR a1,=g_WATCHDOG_RESTART_REG @ Restart watchdog
   LDR a1,[a1]
   LDR a2,=g_WATCHDOG_RESTART_VALUE
   LDR a2,[a2]
   STR a2,[a1]




   MOV v1,lr
   MOV v2,sp

   INT_TRC 0x0000


   MOV r0, #0
   BL cp15_switch_vector



   @
   MOV r0, #0x2
   BL cp15_set_bp_policy


   INT_TRC 0x0001
   @ Enable ARM9 TCM
# 1074 "driver/sys_drv/init/src/bootarm_gcc.S"
   @ Enable ARM11 TCM
# 1155 "driver/sys_drv/init/src/bootarm_gcc.S"
    BL DENALI_1_SRAM_DELSEL_WORKAROUND


    @ disable 64-bit read-modify-write of TCMs;
    BL cp15_disable_atcmrmw
    BL cp15_disable_btcmrmw

    @ MT6595: atcm placed before btcm

    LDR r0, =Image$$EMIINIT_CODE$$Base
    BL cp15_enable_atcm

    LDR r0, =Image$$INTSRAM_PHYSICAL_BOUNDARY$$Base
    BL cp15_enable_btcm
# 1180 "driver/sys_drv/init/src/bootarm_gcc.S"
   INT_TRC 0x0002
   LDR a1,ABN_RST_PTR
   STR v1,[a1]
   STR v2,[a1,#0x4]

   LDR a1, BOOT_SYS_Stack_End_Local
   MOV sp,a1 @ Setup initial stack pointer


   INT_TRC 0x0003
   LDR a1,ABN_RST_PTR
   BL INT_SystemReset_Check
# 1202 "driver/sys_drv/init/src/bootarm_gcc.S"
   BL SST_DTLB_Init

   INT_TRC 0x0005
   BL INT_GetRandomSeed





   MOV r11,a1



   @
   LDR r0, =Image$$INTSRAM_DATA$$Base
   BL INT_BackupBLShareinfo


   INT_TRC 0x0006
   BL INT_InitEMIInitCode


   BL INT_ecoVersion
   LDR a2, ECO_VERSION_PTR
   STR a1,[a2]


   INT_TRC 0x0007
   BL INT_Config
# 1240 "driver/sys_drv/init/src/bootarm_gcc.S"
   INT_TRC 0x0008



   BLX MpuPreInit




   BL INT_InitPreInitData

   LDR r0, =Image$$INTSRAM_DATA$$Base
   BL INT_RetrieveBLShareinfo @ pass service




   INT_TRC 0x0009
   BL INT_InitRegions @ in regioninit.s





   BLX mddbg_init


   INT_TRC 0x000A
   BL DCM_Prerequisite
# 1288 "driver/sys_drv/init/src/bootarm_gcc.S"
   LDR a2,RAND_NUM_SEED_PTR
   STR r11,[a2]
# 1299 "driver/sys_drv/init/src/bootarm_gcc.S"
   @
   INT_TRC 0x000E
   BL CacheInit






   @
   MOV r0, #0x0
   BL cp15_set_bp_policy



   BL INT_InitMMRegions

   MOV a1,#1 @ All vectors are assumed loaded
   LDR a2, Loaded_Flag
   STR a1,[a2,#0] @ Initialize loaded flag

   @
   INT_TRC 0x000F


   LDR a1, BOOT_SYS_Stack
# 1338 "driver/sys_drv/init/src/bootarm_gcc.S"
   LDR a4, System_Stack
   STR sp,[a4, #0] @ Save stack pointer

   LDR a3,BOOT_IRQ_Stack_End
   MRS a1,CPSR @ Pickup current CPSR
   BIC a1,a1,#0x3F @ Clear the mode bits
   ORR a1,a1,#0x32 @ Set the IRQ mode bits
   MSR CPSR_cxsf,a1 @ Move to IRQ mode
   MOV sp,a3 @ Setup IRQ stack pointer

   SUB sp, #8 @ Nucleus V2 sp adjust


   LDR a3,BOOT_FIQ_Stack_End
   MRS a1,CPSR @ Pickup current CPSR
   BIC a1,a1,#0x3F @ Clear the mode bits
   ORR a1,a1,#0x31 @ Set the FIQ mode bits
   MSR CPSR_cxsf,a1 @ Move to the FIQ mode
   MOV sp,a3 @ Setup FIQ stack pointer

   SUB sp, #8 @ Nucleus V2 sp adjust


   LDR a3,BOOT_ABT_Stack_End
   MRS a1,CPSR @ Pickup current CPSR
   BIC a1,a1,#0x3F @ Clear the mode bits
   ORR a1,a1,#0x37 @ Set the Abort mode bits
   MSR CPSR_cxsf,a1 @ Move to the Abort mode
   MOV sp,a3 @ Setup Abort stack pointer

   LDR a3,BOOT_UND_Stack_End
   MRS a1,CPSR @ Pickup current CPSR
   BIC a1,a1,#0x3F @ Clear the mode bits
   ORR a1,a1,#0x3b @ Set the Undefine mode bits
   MSR CPSR_cxsf,a1 @ Move to the Undefine mode
   MOV sp,a3 @ Setup Undefine stack pointer


   LDR a3,BOOT_SYS_Stack_End_Local



   MRS a1,CPSR @ Pickup current CPSR
   BIC a1,a1,#0x3F @ Clear the mode bits

   ORR a1,a1,#0x33 @ Set the Supervisor mode bits



   MSR CPSR_cxsf,a1 @ Move to the System/Supervisor mode
   MOV sp,a3 @ Setup System/Supervisor stack pointer

   MRS a1,CPSR @ Pickup current CPSR
   BIC a1,a1,#0x3F @ Clear mode bits
   ORR a1,a1,#0x3f @ Set the kernel running mode bits
   MSR CPSR_cxsf,a1 @ All interrupt stacks are setup,

   INT_TRC 0x0010
   MOV a1, #0



   LDR a4,=INC_Initialize @ to high-level initialization
   BX a4






.size INT_Initialize, .-INT_Initialize
@}



   .end
