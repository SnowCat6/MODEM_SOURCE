# 1 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
# 27 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
# 1 "driver/sys_drv/dormant/src/cortexr4_dorm_macros_gcc.hs" 1
# 29 "driver/sys_drv/dormant/src/cortexr4_dorm_macros_gcc.hs"
  .extern enableVirtualMapping
  .extern enablePrefetchBuffer
  .extern clear_bus_err_int
  .extern dormant_dbg_ptr
      .equ DORMANT_DPFB_IN, 0xDA01
      .equ DORMANT_DPFB_OUT, 0xDA02
      .equ DORMANT_RST_EPFB_IN, 0xDA03
      .equ DORMANT_RST_EPFB_OUT, 0xDA04
      .equ DORMANT_ABT_EPFB_IN, 0xDA05
      .equ DORMANT_ABT_EPFB_OUT, 0xDA06
      .equ DORMANT_REMAP_EMI_IN, 0xDA07
      .equ DORMANT_REMAP_EMI_OUT, 0xDA08
      .equ DORMANT_REMAP_BSV_IN, 0xDA09
      .equ DORMANT_REMAP_BSV_OUT, 0xDA0A

# Important. Don't forget to include this:
# 1 "driver/sys_drv/dormant/src/cortexr4_dorm_arch_macros_gcc.hs" 1
# 33 "driver/sys_drv/dormant/src/cortexr4_dorm_arch_macros_gcc.hs"
        .macro PMU_SAVE label
 # Save a pointer to the start of the PMU context offset
  STR r0,[r12,#DM_PMU]
 # Save Performance Monitor Registers - PMU.
 # :ASSUMPTION: These should be saved as early as possible to make them
 # 'transparent' to power mangement overheads
 # Ignore:
 # Count Enable Clear Register
 # Software Increment Register
 # Interrupt Enable Clear Register
  MRC p15,0,r8,c9,c12,0
  BIC r1,r8,#1
  MCR p15,0,r1,c9,c12,0
  ISB
  MRC p15,0,r9,c9,c12,3
  MRC p15,0,r10,c9,c12,5
  STM r0!,{r8-r10}

  UBFX r9,r8,#11,#5
  TST r9,r9
  BEQ \label\().continue
\label\().loop:
  SUBS r9,r9,#1
  MCR p15,0,r9,c9,c12,5
  ISB
  MRC p15,0,r3,c9,c13,1
  MRC p15,0,r4,c9,c13,2
  STM r0!,{r3,r4}
  BNE \label\().loop
\label\().continue:
  MRC p15,0,r1,c9,c13,0
  MRC p15,0,r2,c9,c14,0
  MRC p15,0,r3,c9,c14,1
  MRC p15,0,r4,c9,c12,1

  STM r0!,{r1-r4}

 # Restore the original value of the Selection Register
  MCR p15,0,r10,c9,c12,5
  MCR p15,0,r8,c9,c12,0

                .endm





        .macro PMU_RESTORE label
 # NOTE: all counters disabled by PMCR<0> == 0 on reset
 # Restore performance counters
  LDR r0,[r12,#DM_PMU]
  LDM r0!,{r8-r10}

  MOV r1,#0
  MVN r2,#0
  MCR p15,0,r2,c9,c14,2
  MCR p15,0,r2,c9,c12,3
  MCR p15,0,r2,c15,c1,4
  MCR p15,0,r2,c15,c1,5
  MCR p15,0,r2,c15,c1,6
  MCR p15,0,r2,c15,c1,7
  ISB

  UBFX r11,r8,#11,#5
  TST r11,r11
  BEQ \label\().continue
  MOV r3,r11
  MOV r4,#1
  LSL r4,r3
  SUB r4,r4,#1
\label\().loop1:
  SUBS r3,r3,#1
  MCR p15,0,r3,c9,c12,5
  ISB
  MRC p15,0,r5,c9,c13,1
  BFC r5,#0,#8
  MCR p15,0,r5,c9,c13,1
  MCR p15,0,r2,c9,c13,2
  ISB
  BNE \label\().loop1

  MOV r3,#1
  MCR p15,0,r4,c9,c12,1
  MCR p15,0,r3,c9,c12,0
  ISB
  MCR p15,0,r9,c9,c12,4
  ISB
  MCR p15,0,r4,c9,c12,2

 # restore the event counters
\label\().loop2:
  SUBS r11,r11,#1
  MCR p15,0,r11,c9,c12,5
  ISB
  LDM r0!,{r3-r4}
  MCR p15,0,r3,c9,c13,1
  MCR p15,0,r4,c9,c13,2
  ISB
  BNE \label\().loop2
\label\().continue:
  TST r9,#0x80000000
  BEQ \label\().continue2
  MCR p15,0,r2,c9,c13,0
  ISB
  MOV r3,#0x80000000
  MCR p15,0,r3,c9,c12,1
  ISB
\label\().loop3:
  MRC p15,0,r4,c9,c12,3
  MOVS r4,r4
  BPL \label\().loop3
  MCR p15,0,r3,c9,c12,2
\label\().continue2:

  MCR p15,0,r1,c9,c12,0
  ISB

 # restore the remaining PMU registers
  LDM r0!,{r1-r4}
  MCR p15,0,r1,c9,c13,0
  MCR p15,0,r2,c9,c14,0
  MCR p15,0,r3,c9,c14,1
  MCR p15,0,r4,c9,c12,1

  MCR p15,0,r10,c9,c12,5
  ISB
  MCR p15,0,r8,c9,c12,0
  ISB

                .endm






                .macro PMU_DORMANT_DISABLE
  MRC p15,0,r1,c9,c12,0
  STR r1,[r0,#DM_PMU_ST]
  BIC r1,#1
  MCR p15,0,r1,c9,c12,0
  ISB
                .endm






                .macro PMU_DORMANT_RESTORE
  LDR r0,[r0,#DM_PMU_ST]
  MCR p15,0,r0,c9,c12,0
  ISB
                .endm





                .macro MPU_SAVE label
\label :
  STR r0,[r12, #DM_MPU]

 # fault address and status information
  MRC p15,0,r2,c5,c0,0
  MRC p15,0,r3,c5,c0,1
  MRC p15,0,r4,c5,c1,0
  MRC p15,0,r5,c5,c1,1
  MRC p15,0,r6,c6,c0,0
  MRC p15,0,r7,c6,c0,2
  STM r0!,{r2-r7}

  MRC p15,0,r7,c6,c2,0
  STR r7,[r0], #4

  MRC p15,0,r1,c0,c0,4
  EOR r2,r2
 # determine if unified or Harvard region support
  ANDS r3,r1,#1
  IT NE
  UBFXNE r2,r1,#16,#8
  UBFX r1,r1,#8,#8

  # Save unified/data region context
  CMP r1,#0
  BEQ \label\().SaveIregionContext

  EOR r3,r3
\label\().SaveDregionContextLoop:
  MCR p15,0,r3,c6,c2,0
  ISB
  MRC p15,0,r4,c6,c1,0
  MRC p15,0,r5,c6,c1,2
  MRC p15,0,r6,c6,c1,4
  STM r0!, {r4-r6}
  ADDS r3,r3,#1
  CMP r1,r3
  BNE \label\().SaveDregionContextLoop

\label\().SaveIregionContext:
 # test for case of unified regions or no MPU fitted
  CMP r2,#0
  BEQ \label\().ContinuePwrDwnSave

  EOR r3,r3
\label\().SaveIregionContextLoop:
  MCR p15,0,r3,c6,c2,0
  ISB
  MRC p15,0,r4,c6,c1,1
  MRC p15,0,r5,c6,c1,3
  MRC p15,0,r6,c6,c1,5
  STM r0!,{r4-r6}
  ADDS r3,r3, #1
  CMP r2,r3
  BNE \label\().SaveIregionContextLoop

\label\().ContinuePwrDwnSave:
  MCR p15,0,r7,c6,c2,0

                .endm






                .macro MPU_RESTORE label
\label :
  LDR R0,[R12,#DM_MPU]

 # Fault status & address context
  LDM r0!,{r2-r7}
  MCR p15,0,r2,c5,c0,0
  MCR p15,0,r3,c5,c0,1
  MCR p15,0,r4,c5,c1,0
  MCR p15,0,r5,c5,c1,1
  MCR p15,0,r6,c6,c0,0
  MCR p15,0,r7,c6,c0,2
  ISB

 # recover RGNR to r7. It will be restored later
  LDR r7,[r0],#4

  MRC p15,0,r1,c0,c0,4
  EORS r2,r2
 # determine if unified or Harvard region support
  ANDS r3,r1,#1
  IT NE
  UBFXNE r2,r1,#16,#8
  UBFX r1,r1,#8,#8

 # Restore unified/data region context
  CMP r1,#0
  BEQ \label\().RestoreIregionContext

  EORS r3,r3
\label\().RestoreDregionContextLoop:
  LDM r0!,{r4-r6}
  MCR p15,0,r3,c6,c2,0
  ISB
  MCR p15,0,r4,c6,c1,0
  MCR p15,0,r5,c6,c1,2
  MCR p15,0,r6,c6,c1,4
  ADDS r3,r3,#1
  CMP r1,r3
  BNE \label\().RestoreDregionContextLoop

\label\().RestoreIregionContext:
 # test for case of unified regions or no MPU fitted
  CMP r2, #0
  BEQ \label\().ContinuePwrDwnRestore

  EORS r3,r3
\label\().RestoreIregionContextLoop:
  LDM r0!,{r4-r6}
  MCR p15,0,r3,c6,c2,0
  ISB
  MCR p15,0,r4,c6,c1,1
  MCR p15,0,r5,c6,c1,3
  MCR p15,0,r6,c6,c1,5
  ADDS r3,r3,#1
  CMP r2,r3
  BNE \label\().RestoreIregionContextLoop

\label\().ContinuePwrDwnRestore:
  MCR p15,0,r7,c6,c2,0

               .endm





               .macro VFP_SAVE label
\label :
# 382 "driver/sys_drv/dormant/src/cortexr4_dorm_arch_macros_gcc.hs"
                .endm





                .macro VFP_RESTORE label
\label :
# 437 "driver/sys_drv/dormant/src/cortexr4_dorm_arch_macros_gcc.hs"
                .endm





                .macro REG_BARRIER dir

# #if (\"dir" == "RESTORE")
  MOV r0,#0
# #endif
  MOV r1,#0
  MOV r2,#0
  MOV r3,#0
  MOV r4,#0
  MOV r5,#0
  MOV r6,#0
  MOV r7,#0
  MOV r8,#0
  MOV r9,#0
  MOV r10,#0
  MOV r11,#0

                .endm

                .macro REG_BARRIER_SAVE
# REG_BARRIER SAVE

  MOV r1,#0
  MOV r2,#0
  MOV r3,#0
  MOV r4,#0
  MOV r5,#0
  MOV r6,#0
  MOV r7,#0
  MOV r8,#0
  MOV r9,#0
  MOV r10,#0
  MOV r11,#0

                .endm

                .macro REG_BARRIER_RESTORE
# REG_BARRIER RESTORE

  MOV r0,#0
  MOV r1,#0
  MOV r2,#0
  MOV r3,#0
  MOV r4,#0
  MOV r5,#0
  MOV r6,#0
  MOV r7,#0
  MOV r8,#0
  MOV r9,#0
  MOV r10,#0
  MOV r11,#0

                .endm

# Kirk
# Following macros are used to make compile pass
# Need to check with aRM whether these codes are necessary

                .macro DISABLE_ITCM_CTL param1, param2
                .endm

                .macro ENABLE_ITCM_CTL param1, param2
                .endm

                .macro DISABLE_DTCM_CTL param1, param2
                .endm

                .macro ENABLE_DTCM_CTL param1, param2
                .endm

                .macro SET_EXCEPTION param1, param2, param3, param4, param5
                .endm
# 46 "driver/sys_drv/dormant/src/cortexr4_dorm_macros_gcc.hs" 2

# Those are compile time configurable parameters that we need:




#0 SETL {FALSE}
#0 SETL {FALSE}
#0 SETL {FALSE}
#0 SETL {FALSE}






# Aliases for mode encodings - do not change
        .equ MODE_USR, 0x10
        .equ MODE_FIQ, 0x11
        .equ MODE_IRQ, 0x12
        .equ MODE_SVC, 0x13
        .equ MODE_ABT, 0x17
        .equ MODE_UND, 0x1B
        .equ MODE_SYS, 0x1F

# Entry point offsets for key context variable and pointer values

# Maintain correlation with the offset comments/size on reserved space at the
# start of DORMANT_BASE.
        .equ DM_SYSCACHE, 0x00
        .equ DM_DBG, 0x04
        .equ DM_PMU, 0x08
        .equ DM_ACTLR, 0x0C
        .equ DM_SCTLR, 0x10
        .equ DM_SACTLR, 0x14
        .equ DM_CPACR, 0x18
        .equ DM_AXISLVCR, 0x1C
        .equ DM_VFP, 0x20
        .equ DM_MPU, 0x24
        .equ DM_SC, 0x28
        .equ DM_C_OVER, 0x2C
        .equ DM_ENDIAN, 0x30
        .equ DM_OLD_VECTOR, 0x34
        .equ DM_EXTRAS, 0x38
        .equ DM_PMU_ST, 0x3C
        .equ DM_BLOCK, 0x40



 # DORMANT_SAVE should NOT modify the state of the processor (should be
 # able to be called independently of the DORMANT_RESTORE function.
 # Uses registers and the CPSR.
 # R0 base address to save content of registers other than TCM region
 # R1 base address to save TCM region registers
                .macro DORMANT_SAVE label

 # Save all Supervisor mode context for nucleus 1.x Or
 # Save all System mode context for nucleus 2.x

                CPS #MODE_SVC

 # Account for a block to save some DM_* configurations (fixed offset).
  ADD r0,r0,#DM_BLOCK
 # save ARM registers (but PC)
  STM r0!,{r2-r14}
 # preserve a copy of DORMANT_BASE
  SUB r12,r0, #(DM_BLOCK + 4*13)
  MRS r4,CPSR
  MRS r5,SPSR
 # Save endianness.
 # This creates a reg that is 0 when we have l.endian and 0xffffffff
 # for b. endian.This should be checked before restore to restore data
 # correctly.
  SBFX r7,r4,#9,#1
  STR r4,[r12,#DM_ENDIAN]
  STM r0!,{r4-r5}
 # Make a dummy STREX to check if memory is locked.
 # If r6=1 it means that the lock was free if r6=0 it means that the
 # lock was held
  STREX r6,r1,[r1]
 # Save TCM Region Registers (always present in Cortex-R4)
  MRC p15,0,r4,c9,c1,0
  MRC p15,0,r5,c9,c1,1
  STM r1,{r4-r7}
  STM r0!,{r1,r6}

 # Save banked ARM registers
  CPS #MODE_SYS
  STR SP,[r0], #4
  STR LR,[r0], #4

  CPS #MODE_ABT
  STR SP,[r0], #4
  MRS r4,SPSR
  STM r0!,{r4,LR}
  CPS #MODE_UND
  STR SP,[r0], #4
  MRS r4,SPSR
  STM r0!,{r4,LR}
  CPS #MODE_IRQ
  STR SP,[r0], #4
  MRS r4,SPSR
  STM r0!,{r4,LR}
  CPS #MODE_FIQ
  STR SP,[r0], #4
  MRS r4,SPSR
  STM r0!,{r4,r8-r12,LR}

  CPS #MODE_SVC


 # Save performance monitor registers.

  REG_BARRIER_SAVE
  PMU_SAVE PMUS



 # Save the Secondary Control Registers
 # IMPLEMENTATION DEFINED - proprietary features: CP15 register 15
 # SACTLR - Secondary Auxiliary Control Register
  MRC p15,0,r3,c15,c0,0
 # Generic CP15 registers
 # ACTLR - Auxiliary Control Register
   MRC p15,0,r4,c1,c0,1
 # SCTLR - System Control Register
   MRC p15,0,r5,c1,c0,0
 # CPACR - Coprocessor Access Control Register
   MRC p15,0,r6,c1,c0,2
 # AXISLVCR - (AXI) Slave Port Control Register
  MRC p15,0,r7,c11,c0,0
  STR r3,[r12, #DM_SACTLR]
  STR r4,[r12, #DM_ACTLR]
  STR r5,[r12, #DM_SCTLR]
  STR r6,[r12, #DM_CPACR]
  STR r7,[r12, #DM_AXISLVCR]

 # Format and store the Cache override register.
   STR r0,[r12, #DM_C_OVER]
  MRC p15,2,r3,c0,c0,0

  MOV r4,#0
  MCR p15,2,r4,c0,c0,0
 # Read the size from Cache Size Identification Register
  MRC p15,1,r5,c0,c0,0
  LSR r5,r5,#(13+5-4)
  AND r2,r5,#0xF0

  MOV r4,#1
  MCR p15,2,r4,c0,c0,0
 # Read the size from Cache Size Identification Register
  MRC p15,1,r5,c0,c0,0
  LSR r5,r5,#(13+5)
  AND r5,r5,#0x0F
  ORR r2,r2,r5

  STM r0!,{r2-r3}

 # Set the cache size override register
  LDR r0,[r12,#DM_C_OVER]
  LDM r0!,{r2-r3}
  MCR p15,2,r3,c0,c0,0

 # Store TCM regions and Software and thread context
  STR r0,[r12, #DM_SC]
  # Save the software context and thread support registers
  MRC p15,0,r4,c13,c0,1
  MRC p15,0,r5,c13,c0,2
  MRC p15,0,r6,c13,c0,3
  MRC p15,0,r7,c13,c0,4
  STM r0!,{r4-r7}

 # Extras
  STR r0,[r12, #DM_EXTRAS]
  MRC p15,0,r3,c15,c3,0
  MRC p15,0,r4,c15,c1,0
  MRC p15,0,r5,c15,c1,1
  MRC p15,0,r6,c15,c1,2
  MRC p15,0,r7,c15,c1,3
  STM r0!, {r3-r7}


 # Save MPU configuration

  REG_BARRIER_SAVE
  MPU_SAVE MPUS



##########################################################################
# DEBUG: ARMv7 OS Lock support
# ### OMITTED FOR CORTEX-R4 ###

##############################################################################


\label\().DBGS:

  EORS r1, r1
  STR r1,[r12,#DM_DBG]



  # FPU state save





                EORS r2, r2
                STR r2,[r12,#DM_VFP]



 # Restore the exclusiveness (DORMANT_SAVE has to be transparent)
  ADD r1,r12,#DM_BLOCK
  LDR r1,[r1, #8]
  CMP r1,#0
  LDREXEQ r1,[r12]

 # R0 will have the number of bytes written
  SUB r0,r0,r12

               .endm

#------------------------------------------------------------------------------
# Macro: DORMANT_RESTORE

# Function: Restores the values stored with the macro DORMANT_SAVE
                .macro DORMANT_RESTORE label
 # R12 is base address for dormant context stored in TCM.
 # R1 is base address for dormant context stored in EMI.
 # Restore endianess because after reset it could be BE or LE node
 # according to the pin configuration.
  LDR r4,[r1,#12]
  CMP r4,#0
  BNE \label\().set_be
  SETEND LE
  B \label\().setend_end
\label\().set_be:
  SETEND BE
\label\().setend_end:
 # Restore TCM Region Registers (always present in Cortex-R4)
  LDM r1!,{r5-r6}
  MCR p15,0,r5,c9,c1,0
  MCR p15,0,r6,c9,c1,1
 # Now, we can use TCM.
  MOV r12, r0

 # Software fix for the hardware L1 cache issue (500166).




 # Restore the TCM error correction scheme
  DSB
  MRC p15,0,r1,c1,c0,1
  BIC r2,r1,#0x7<<25
  LDR r3,[r12,#DM_ACTLR]
  AND r4,r3,#0x7<<25
  ORR r2,r2,r4
  MCR p15,0,r2,c1,c0,1

  MRC p15,0,r2,c15,c0,0
  LDR r3,[r12,#DM_SACTLR]
  BIC r2,#0x0f
  AND r3,#0x0f
  ORR r2,r2,r3
  MCR p15,0,r2,c15,c0,0

  ISB

  LDR r0,[r12,#DM_SC]
 # Restore the software context and thread support registers
  LDM r0!,{r4-r7}
  MCR p15,0,r4,c13,c0,1
  MCR p15,0,r5,c13,c0,2
  MCR p15,0,r6,c13,c0,3
  MCR p15,0,r7,c13,c0,4
 # Apply all the updates to the CP15 registers.
  ISB

 # Restore MPU configuration

                REG_BARRIER_RESTORE
                MPU_RESTORE MPUR


 # Set the cache size override register
  LDR r0,[r12,#DM_C_OVER]
  LDM r0!,{r2-r3}
  MCR p15,0,r2,c15,c14,0
  MCR p15,2,r3,c0,c0,0

 # Enable the MPU if it was enabled before dormant.
  LDR r2,[r12,#DM_SCTLR]
                AND r3,r2,#1
                MRC p15,0,r4,c1,c0,0
  ORR r4,r3
                DMB
                MCR p15,0,r4,c1,c0,0
  ISB

 # Enable cache error correction before enabling caches.
  MRC p15,0,r1,c1,c0,1
  BIC r2,r1,#7<<3
  LDR r3,[r12,#DM_ACTLR]
  AND r4,r3,#7<<3
  ORR r2,r2,r4
  MCR p15,0,r2,c1,c0,1
  ISB

 # - and is it critical where they are in the restore sequence?
 # restore ACTLR and SCTLR, enables caches and MPU if their control
 # bits are set restore SACTLR & AXISLVCR enables ECC, FP and AXI slave
 # access features

  LDR r3,[r12,#DM_SACTLR]
  LDR r4,[r12,#DM_ACTLR]
  LDR r5,[r12,#DM_SCTLR]
 # recover AXISLVCR from fixed address
  LDR r7,[r12,#DM_AXISLVCR]
 # AXISLVCR - (AXI) Slave Port Control Register
  MCR p15,0,r7,c11,c0,0
 # SACTLR - Secondary Auxiliary Control Register
   BIC r3,r3,#1<<21
  MCR p15,0,r3,c15,c0,0
 # ACTLR - Auxiliary Control Register
  BIC r4,r4,#1<<12
  MCR p15,0,r4,c1,c0,1
  ISB
 # SCTLR - System Control Register
  BIC r5,r5,#0x1000
  BIC r5,r5,#0x4
  MCR p15,0,r5,c1,c0,0
  ISB



     LDR r4, dormant_dbg_ptr_local
     LDR r4, [r4]
     MOVW r5, #DORMANT_REMAP_EMI_IN
     MOVW r6, #DORMANT_REMAP_EMI_OUT
  STR r5, [r4]

  DSB
  BLX enableVirtualMapping

  STR r6, [r4]



 # Enable L1 caches if they were enabled before dormant.
  LDR r2,[r12,#DM_SCTLR]
  AND r3,r2,#0x1000
  MRC p15,0,r4,c1,c0,0
  ORR r4,r3
  DMB
  MCR p15,0,r4,c1,c0,0
  ISB
  AND r3,r2,#0x4
                MRC p15,0,r4,c1,c0,0
  ORR r4,r3
  DMB
  MCR p15,0,r4,c1,c0,0
  ISB

 # Enable error injectors if they were enabled before.
  LDR r3,[r12,#DM_SACTLR]
  LDR r4,[r12,#DM_ACTLR]
  MCR p15,0,r3,c15,c0,0
  MCR p15,0,r4,c1,c0,1
  ISB

 # SET_EXCEPTION shouldn't do any cache maintenance operations
 # Cache maintenance OPS on dormand code might cause imprecise
 # that aren't dormand's responsibility to handle e.g. cleaning
 # cache lines with tags with parity errors cause imp. aborts.
  SET_EXCEPTION RESET,r0,r4,"NO_CLEAN","SKIP"

 # Restore VFP







 # Restore banked ARM registers
  ADD R0,R12,#(DM_BLOCK+4*17)
  CPS #MODE_SYS
  LDR SP,[r0],#4
  LDR LR,[r0],#4

  CPS #MODE_ABT
  LDR SP,[r0],#4
  LDM r0!,{r4,LR}
  MSR SPSR_fsxc,r4
  CPS #MODE_UND
  LDR SP,[r0],#4
  LDM r0!,{r4,LR}
  MSR SPSR_fsxc,r4
  CPS #MODE_IRQ
  LDR SP,[r0],#4
  LDM r0!,{r4,LR}
  MSR SPSR_fsxc,r4
  CPS #MODE_FIQ
  LDR SP,[r0],#4
  LDM r0!,{r4,r8-r12,LR}
  MSR SPSR_fsxc,r4

  CPS #MODE_SVC

 # Restore CPACR. This must be done after configuring FPU
  LDR r6,[r12,#DM_CPACR]
  MCR p15,0,r6,c1,c0,2

 # Restore performance counters

                REG_BARRIER_RESTORE
                PMU_RESTORE PMUR


 # Restore extras (this should be after PMU that clears validation regs)
  LDR r0,[r12,#DM_EXTRAS]
  LDM r0!,{r3-r7}
  MCR p15,0,r3,c15,c3,0
  MCR p15,0,r4,c15,c1,0
  MCR p15,0,r5,c15,c1,1
  MCR p15,0,r6,c15,c1,2
  MCR p15,0,r7,c15,c1,3
  ISB

 # Restore MTK HW platform setting

     LDR r4, dormant_dbg_ptr_local
     LDR r4, [r4]
     MOVW r5, #DORMANT_RST_EPFB_IN
     MOVW r6, #DORMANT_RST_EPFB_OUT
  STR r5, [r4]

  DSB
  BLX enablePrefetchBuffer

  STR r6, [r4]


 # clear bus error interrupt




 # Restore Supervisor mode context for nucleus 1.x Or
 # Restore System mode context for nucleus 2.x
 # initial restore of r0, DORMANT_BASE pointer
  ADD r0,r12,#(DM_BLOCK+4*13)
  LDM r0,{r1-r4}
  CMP r4,#0
  LDREXEQ r4,[r3]
  MSR CPSR_fsxc,r1
  MSR SPSR_fsxc,r2
  ADD r0,r12,#DM_BLOCK
  LDM r0,{r2-r14}


  CPS #MODE_SYS


               .endm


#------------------------------------------------------------------------------
# Macro: R1P2_FIX_500166

# Function: Software fix for the hardware L1 cache issue 500166.
# Assumes: r12 has the DORMANT_BASE. Uses: r0,r1,r2.
# NOTE: TCMs are max 8Mb long and we would like to guarantee that
# we hit WB (thus non-tcm) region so we do the trick in address,
# address+8Mb and address+16Mb (to cover 2 tcms).
                .macro R1P2_FIX_500166
  LDR r0,[r12,#DM_C_OVER]
  LDR r2,[r0]
  MCR p15,0,r2,c15,c14,0
  DSB

 # a) Data cache and MPU already disabled so we clean and invalidate
  MOV32 r1,#0x01400000
  MCR p15,0,r1,c7,c14,1
  DSB

 # b) Enable data cache and DMB
  MRC p15,0,r0,c1,c0,0
  ORR r0,r0,#0x00000004
  MCR p15,0,r0,c1,c0,0
  DSB

 # c) Load from address in r1 and DMB
  LDR r0,[r1]
  DSB

 # d) Disable data cache and DMB
  MRC p15,0,r0,c1,c0,0
  BIC r0,r0,#0x00000004
  MCR p15,0,r0,c1,c0,0
  DSB

 # d) Invalidate line after the load.
  MCR p15,0,r1,c7,c6,1
  DSB
                .endm

#------------------------------------------------------------------------------
# Macro: [label] TCM_error_disable

# Function: r1 should be 1 to disable the etm errors or 0 to re-enable them
# Uses as temporaries r2, r3, r4, r5, r6
                .macro TCM_error_disable label

  AND r1,#1

  MRC p15,0,r2,c15,c2,1
  UBFX r2,r2,#13,#1
  CMP r2,#1
  BEQ \label\().ATCM_error_exit

        # Step 1 : Enable ATCM validation wrapper

 # Step 2 : Program ATCM Wrapper control registers. If the ATCM
 # is used as a fetch memory, the base address of the ATCM should
 # not be changed. Otherwise the ATCM is set-up at the address
 # location 0x6000000.
  ENABLE_ITCM_CTL r3,r4
  MRC p15,0,r6,c9,c1,1






  MOV r2,#0x6000000
  MOV r5,r2

  ORR r5,r5,#1
  MCR p15,0,r5,c9,c1,1
  LDR r5,[r2,#0x610]
  BIC r5,r5,#(1<<30)
  ORR r5,r5,r1,LSL #30
  STR r5,[r2,#0x610]
  DSB
  MCR p15,0,r6,c9,c1,1
  DISABLE_ITCM_CTL r3,r4

\label\().ATCM_error_exit:

  MRC p15,0,r2,c15,c2,1
  UBFX r2,r2,#11,#2
  CMP r2,#3
  BEQ \label\().BTCM_error_exit

 # Step 2 : Program B0TCM and B1TCM Wrapper control registers.
        # If the BTCM is used as a fetch memory, the base address of
        # the BTCM should not be changed. Otherwise the BTCM is set-up
        # at the address location 0x6000000.
  ENABLE_DTCM_CTL r3,r4
  MRC p15,0,r6,c9,c1,0






  MOV r2,#0x6000000
  MOV r5,r2

  ORR r5,r5,#1
  MCR p15,0,r5,c9,c1,0
  LDR r5,[r2,#0x610]
  BIC r5,r5,#(1<<30)
  ORR r5,r5,r1,LSL #30
  STR r5,[r2,#0x610]
  DSB
  MCR p15,0,r6,c9,c1,0
  DISABLE_DTCM_CTL r3,r4

\label\().BTCM_error_exit:
 # Step 3 : Disable ITCM wrapper and enable DTCM wrapper
                .endm
# 28 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S" 2



    .text
                .arm
    .align 2




  .extern dormant_tcm_storage
  .extern dormant_mode_storage
  .extern dormant_reset_frc
  .extern dormant_standby_frc
  .extern dormant_abort_frc
  .extern dormant_reset_count
  .extern dormant_abort_count

  .extern dormant_status_reg
  .extern dormant_power_ack_mask
  .extern dormant_frc_val
  .extern dormant_remapping_val
  .extern dormant_mode_stack

  .extern disableVirtualMapping
  .extern enableVirtualMapping
  .extern disablePrefetchBuffer
  .extern enablePrefetchBuffer
  .extern dormant_mode_abort_reset
  .extern mddbg_restore

  .extern dormant_alc_reg


  .extern dormant_cache_flush_start_frc
  .extern dormant_cache_flush_end_frc
# 79 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
@void arm_dormant_reset_handler(void)
    .global arm_dormant_reset_handler
    .type arm_dormant_reset_handler, %function
arm_dormant_reset_handler:
# 98 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
   LDR r0, dormant_hw_frc_val
   LDR r1, dormant_sw_reset_frc
   LDR r0, [r0]
   LDR r0, [r0]
   STR r0, [r1]


   LDR r0, dormant_hw_alc_val
   LDR r0, [r0]
   LDR r1, [r0]
   ORR r1, r1, #1
   STR r1, [r0]
# 136 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
    MOV r0,#0

    MCR p15, 0, r0, c15, c5, 0
    DSB

    MCR p15, 0, r0, c7, c5, 0
    ISB
# 169 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
# record reset times
   LDR r0, dormant_reset_round
   LDR r1, [r0]
   ADD r1, #0x1
   STR r1, [r0]

# switch to dormant mode stack
   LDR r0, dormant_stack_point
   LDR r0, [r0]
   MOV sp, r0
   BLX mddbg_restore

# check whether dormant mode is triggered
   LDR r0,dormant_hw_status
   LDR r1,dormant_hw_ack
   LDR r0,[r0]
   LDR r0,[r0]
   LDR r1,[r1]
   ANDS r0,r0,r1
   BEQ arm_halt_loop
   BL leave_dormant_mode

# unexpected reset
arm_halt_loop:
   B arm_halt_loop
.size arm_dormant_reset_handler, .-arm_dormant_reset_handler

dormant_hw_status:
                    .long dormant_status_reg
dormant_hw_ack:
                    .long dormant_power_ack_mask
dormant_hw_frc_val:
                    .long dormant_frc_val






dormant_sw_reset_frc:
                    .long dormant_reset_frc
dormant_sw_standby_frc:
                    .long dormant_standby_frc
dormant_sw_abort_frc:
                    .long dormant_abort_frc
dormant_stack_point:
                    .long dormant_mode_stack
dormant_reset_round:
                    .long dormant_reset_count
dormant_abort_round:
                    .long dormant_abort_count
dormant_interrupt_func:
                    .long dormant_mode_abort_reset
dormant_hw_alc_val:
                    .long dormant_alc_reg

dormant_sw_cache_flush_start_frc:
                    .long dormant_cache_flush_start_frc
dormant_sw_cache_flush_end_frc:
                    .long dormant_cache_flush_end_frc
# 248 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
dormant_hw_remapping_val:
                    .long dormant_remapping_val


dormant_dbg_ptr_local:
                    .long dormant_dbg_ptr
# 319 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
    .global enter_dormant_mode
    .type enter_dormant_mode, %function
enter_dormant_mode:

 PUSH {r0, r1}

 LDR r0,dormant_backup
 LDR r1,dormant_tcm_backup


 DORMANT_SAVE

 LDR r0, dormant_hw_frc_val
 LDR r1, dormant_sw_standby_frc
 LDR r0, [r0]
 LDR r0, [r0]
 STR r0, [r1]

# switch to dormant mode stack
 LDR r0, dormant_stack_point
 LDR r0, [r0]
 MOV sp, r0

# keep virtual mapping register address in arm register to avoid D-cache access when dormant is abot.

 LDR r4, dormant_dbg_ptr_local
 LDR r4, [r4]
 MOVW r5, #DORMANT_DPFB_IN
 MOVW r6, #DORMANT_DPFB_OUT
 STR r5, [r4]

 BLX disablePrefetchBuffer

 STR r6, [r4]




   LDR r0, dormant_hw_frc_val
   LDR r1, dormant_sw_cache_flush_start_frc
   LDR r0, [r0]
   LDR r0, [r0]
   STR r0, [r1]


    BLX cp15_clean_dcache
    DSB


   LDR r0, dormant_hw_frc_val
   LDR r1, dormant_sw_cache_flush_end_frc
   LDR r0, [r0]
   LDR r0, [r0]
   STR r0, [r1]




 MOVW r5, #DORMANT_REMAP_BSV_IN
 MOVW r6, #DORMANT_REMAP_BSV_OUT
 STR r5, [r4]

 LDR r0, dormant_hw_remapping_val
 LDR r7, [r0]
 BLX disableVirtualMapping

 STR r6, [r4]


 DSB
 ISB


 WFI

 # dormant mode debug loop for pause abort
#dbg_loop:
# B dbg_loop

 DSB
 LDR r0, [r7]
 MOV r1, #0xC
 BIC r0, r0, r1, LSL #28
 STR r0, [r7]


# record reset times
 LDR r0, dormant_abort_round
 LDR r1, [r0]
 ADD r1, #0x1
 STR r1, [r0]

 # MCU MTCMOS mode is not triggered due to pause abort
 LDR r0, dormant_hw_frc_val
 LDR r1, dormant_sw_abort_frc
 LDR r0, [r0]
 LDR r0, [r0]
 STR r0, [r1]


 LDR r4, dormant_dbg_ptr_local
 LDR r4, [r4]
 MOVW r5, #DORMANT_ABT_EPFB_IN
 MOVW r6, #DORMANT_ABT_EPFB_OUT
 STR r5, [r4]

 DSB
 BLX enablePrefetchBuffer

 STR r6, [r4]


 # add a log for pause abort event, i.e. MCU did not enter MTCMOS mode
 LDR r1,dormant_interrupt_func
 BLX r1

 # restore register content before DORMAN_SAVE
 LDR r12,dormant_backup

 ADD r0,r12,#(DM_BLOCK+4*13)
 LDM r0,{r1-r4}
 CMP r4,#0
 LDREXEQ r4,[r3]
 MSR CPSR_fsxc,r1
 MSR SPSR_fsxc,r2
 ADD r0,r12,#DM_BLOCK
 LDM r0,{r2-r14}


 CPS #MODE_SYS

 POP {r0, r1}
 # return to caller
 BX lr
.size enter_dormant_mode, .-enter_dormant_mode

#*******************************************************************************
#* Leave dormant mode
#*******************************************************************************

#void leave_dormant_mode(void)

    .global leave_dormant_mode
    .type leave_dormant_mode, %function
leave_dormant_mode:

 LDR r0,dormant_backup

 LDR r1,dormant_tcm_backup


 DORMANT_RESTORE
# 480 "driver/sys_drv/dormant/src/cortexr4-dormantMode_gcc.S"
 POP {r0, r1}
 BX r14
.size leave_dormant_mode, .-leave_dormant_mode

#*******************************************************************************
#* backup and restore routine test mode
#*******************************************************************************

#void dormant_backup_test(void)

    .global dormant_backup_test
    .type dormant_backup_test, %function

dormant_backup_test:
 BL enter_dormant_mode
 BL leave_dormant_mode
.size dormant_backup_test, .-dormant_backup_test

# Data pool
dormant_backup:
                    .long dormant_mode_storage
dormant_tcm_backup:
                    .long dormant_tcm_storage

#*******************************************************************************
#* End of code
#*******************************************************************************

  .end
