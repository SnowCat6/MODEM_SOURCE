# 1 "driver/sys_drv/cache/src/cp15_gcc.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "driver/sys_drv/cache/src/cp15_gcc.S"
# 196 "driver/sys_drv/cache/src/cp15_gcc.S"
# 1 "interface/driver/sys_drv/asm_def.h" 1
# 197 "driver/sys_drv/cache/src/cp15_gcc.S" 2
# 1 "driver/sys_drv/cache/inc/cp15_drv_region_gcc.inc" 1
# 104 "driver/sys_drv/cache/inc/cp15_drv_region_gcc.inc"
@
@ * Common region pragma settings
@ ******************************************************************************/
    @ COMMON
    .macro INSTRUCTION_TCM
    .section "INTSRAM_ROCODE","ax"
    .endm

    @ COMMON
    .macro DATA_TCM_ZI
    .section "INTSRAM_ZI","w", %nobits
    .endm

    @ COMMON
    .macro DATA_TCM_RW
    .section "INTSRAM_RW","w", %progbits
    .endm

    @ COMMON
    .macro DEFAULT_CODE_REGION
    .text
    .endm

    @ COMMON
    @ CACHED_EXTSRAM_RW
    .macro DEFAULT_RWDATA_REGION
    .section ".data","w", %progbits
    .endm

    @ COMMON
    .macro DEFAULT_ZIDATA_REGION
    .section ".bss","w", %nobits
    .endm

    @ COMMON
    .macro NONCACHED_ZIDATA_REGION
    .section "NONCACHEDZI","w", %nobits
    .endm

@
@ * Placement Settings By Project
@ ******************************************************************************/
# 670 "driver/sys_drv/cache/inc/cp15_drv_region_gcc.inc"
    @
    @ * Data Placement *
    @ ************************/
    .macro CACHE_LINE_NR_PLACEMENT @ MT6290
    DATA_TCM_RW
    .endm

    .macro CACHE_LINE_NR_PER_WAY_PLACEMENT @ MT6290
    DATA_TCM_RW
    .endm

    @
    @ * Function Placement *
    @ ************************/
    .macro CP15_ENABLE_MPU_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_DISABLE_MPU_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_ENABLE_ALIGNMENT_FAULT_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_DISABLE_ALIGNMENT_FAULT_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_ABTCM_SELECT_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_ENABLE_BTCM_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_ENABLE_ATCM_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_MPU_SET_RGN_INDEX_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_MPU_SET_RGN_ADDR_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_MPU_SET_RGN_ACCCTRL_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_MPU_SET_RGN_SIZE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_MPU_SET_RGN_ENABLE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_MPU_SET_SUBREGION_DISABLE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_ENABLE_ICACHE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_DISABLE_ICACHE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_DATA_SYNCHRONIZATION_BARRIER_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_INST_SYNCHRONIZATION_BARRIER_PLACEMENT @ MT6290
    INSTRUCTION_TCM
    .endm

    .macro CP15_INVALIDATE_ICACHE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_INVALIDATE_ICACHE_SINGLE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_INVALIDATE_ICACHE_REGION_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_IS_ICACHE_ENABLED_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_DRAIN_WRITE_BUFFER_PLACEMENT @ MT6290
    INSTRUCTION_TCM
    .endm

    .macro CP15_ENABLE_DCACHE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_DISABLE_DCACHE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_INVALIDATE_DCACHE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_INVALIDATE_DCACHE_SINGLE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_CLEAN_DCACHE_SINGLE_PLACEMENT @ MT6290
    INSTRUCTION_TCM
    .endm

    .macro CP15_INVALIDATE_DCACHE_REGION_PLACEMENT @ MT6290
    INSTRUCTION_TCM
    .endm

    .macro CP15_CLEAN_DCACHE_REGION_PLACEMENT @ MT6290
    INSTRUCTION_TCM
    .endm

    .macro CP15_CLEAN_AND_INVALIDATE_DCACHE_REGION_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_CLEAN_DCACHE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_IS_DCACHE_ENABLED_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_CLEAN_AND_INVALIDATE_DCACHE_BY_SETWAY_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_CLEAN_ALL_DCACHE_BY_SETWAY_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_CLEAN_AND_INVALIDATE_ALL_DCACHE_BY_SETWAY_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_READ_DFSR_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_READ_FAR_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_READ_IFSR_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_READ_IFAR_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_ENTER_LOW_PWR_STATE_PLACEMENT @ MT6290
    INSTRUCTION_TCM
    .endm

    .macro CP15_DISABLE_ATCMRMW_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_DISABLE_BTCMRMW_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_DISABLE_LIL_STLDM_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_ENABLE_UNDEF_DIV_BY_ZERO_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_MPU_GET_RBAR_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_MPU_GET_RACR_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_MPU_GET_RSER_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_DATA_MEMORY_BARRIER_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_SWITCH_VECTOR_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_SET_BP_POLICY_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_READ_ICACHE_INFO_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_READ_DCACHE_INFO_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_WRITE_CONTEXT_ID_PLACEMENT @ MT6290
    INSTRUCTION_TCM
    .endm

    .macro CP15_READ_CONTEXT_ID_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_READ_CONTROL_REGISTER_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_VECTOR_INTERRUPT_ENABLE_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_WRITE_CONTROL_REGISTER_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_WRITE_COUNTER_ENABLE_SET_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_READ_COUNTER_ENABLE_SET_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_WRITE_COUNTER_ENABLE_CLEAR_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_READ_COUNTER_OVERFLOW_STATUS_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_WRITE_EVENT_SELECTION_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_READ_CYCLE_COUNTER_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_WRITE_CYCLE_COUNTER_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_READ_EVENT_COUNTER_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    .macro CP15_PMU_WRITE_EVENT_COUNTER_PLACEMENT @ MT6290
    DEFAULT_CODE_REGION
    .endm

    @
    @ * End of MT6290 Placement *
    @ ***************************/
# 198 "driver/sys_drv/cache/src/cp15_gcc.S" 2
# 1 "driver/sys_drv/cache/src/cr4_cp15_gcc.inc" 1
# 90 "driver/sys_drv/cache/src/cr4_cp15_gcc.inc"
    .thumb
    .syntax unified
@


    .equ MPU_RGNNUM_MASK, 0x0000000F
    .equ MPU_BADDR_MASK, 0x0000001F
    .equ MPU_SIZE_MASK, 0xFFFF00C1
    .equ MPU_ENABLE_MASK, 0xFFFFFFFE
    .equ MPU_ACCTRL_MASK, 0xFFFFE8C0
    .equ MPU_SUBREGION_MASK, 0xFFFF00FF

    .equ NUM_OF_SET_MASK, 0x0FFFE000
    .equ NUM_OF_SET_OFFSET, 0x0000000D

    .equ C1_VBIT_MASK, 0x00002000
    .equ C1_DZ_BIT, 0x00080000
    .equ C1_DILSM_BIT, 0x00400000
    .equ C1_VE, 0x01000000
    .equ C1_NMFI_MASK, 0x08000000
    .equ C1_TE, 0x40000000
    .equ C1_MBIT, 0x00000001
    .equ C1_ABIT, 0x00000002
    .equ C1_CBIT, 0x00000004
    .equ C1_IBIT, 0x00001000
    .equ C1_VINITHI, 0x00002000

    .equ C1_CSSELR_InD_BIT, 0x00000001

    .equ C9_ENABLE_BIT, 0x00000001

    .equ C15_ATCMRMW_MASK, 0x00000001
    .equ C15_BTCMRMW_MASK, 0x00000002

    .equ TCM_BADDR_MASK, 0x0000003F

    .equ ICACHE_ENABLE, 0x1000
    .equ DCACHE_ENABLE, 0x4

    .equ BP_MASK, 0xFFFE7FFF
    .equ BP_ALWAYS_NOT_TAKEN,0x00010000
    .equ BP_NORMAL_OPERATION,0x00000000

    .global cache_line_nr
    .global cache_line_nr_per_way

@


    CACHE_LINE_NR_PLACEMENT

 .balign 4

    .global cache_line_nr
cache_line_nr:
    .word 0x1000

    CACHE_LINE_NR_PER_WAY_PLACEMENT
    .global cache_line_nr_per_way
cache_line_nr_per_way:
    .word 0x400
# 161 "driver/sys_drv/cache/src/cr4_cp15_gcc.inc"
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
@VOID cp15_enable_mpu(VOID)
@{
    CP15_ENABLE_MPU_PLACEMENT
 .global cp15_enable_mpu
    .thumb_func

cp15_enable_mpu:
    MRC p15,0,r0,c1,c0,0
    ORR r0,r0,#C1_MBIT
    DSB
    MCR p15,0,r0,c1,c0,0
    ISB

    BX lr
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
@VOID cp15_disable_mpu(VOID)
@{
    CP15_DISABLE_MPU_PLACEMENT
 .global cp15_disable_mpu
    .thumb_func

cp15_disable_mpu:
    MRC p15,0,r0,c1,c0,0
    BIC r0,r0,#C1_MBIT
    DSB
    MCR p15,0,r0,c1,c0,0
    ISB

    BX lr
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
@VOID cp15_enable_alignment_fault(VOID)
@{
@ CP15_ENABLE_ALIGNMENT_FAULT_PLACEMENT
 .global cp15_enable_alignment_fault
    .thumb_func

cp15_enable_alignment_fault:
    MRC p15,0,r0,c1,c0,0
    ORR r0,r0,#C1_ABIT
    MCR p15,0,r0,c1,c0,0

    BX lr
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
@VOID cp15_disable_alignment_fault(VOID)
@{
    CP15_DISABLE_ALIGNMENT_FAULT_PLACEMENT
 .global cp15_disable_alignment_fault
    .thumb_func

cp15_disable_alignment_fault:
    MRC p15,0,r0,c1,c0,0
    BIC r0,r0,#C1_ABIT
    MCR p15,0,r0,c1,c0,0

    BX lr
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
@BOOL cp15_abtcm_select(value) ;useless in CR4 because A and B TCM both have TCM interface
@{
    CP15_ABTCM_SELECT_PLACEMENT
 .global cp15_abtcm_select
    .thumb_func

cp15_abtcm_select:
    MCR p15,0,r0,c9,c2,0

    BX lr
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
@BOOL cp15_enable_btcm(UINT32 addr)
@{
    CP15_ENABLE_BTCM_PLACEMENT
 .global cp15_enable_btcm
    .thumb_func

cp15_enable_btcm:

    MRC p15,0,r1,c9,c1,0
    LDR r2, =TCM_BADDR_MASK
    AND r1,r1,r2
    ORR r0,r0,#C9_ENABLE_BIT
    ORR r0,r0,r1
    MCR p15,0,r0,c9,c1,0


    BX lr

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
@BOOL cp15_enable_atcm(UINT32 addr)
@{
    CP15_ENABLE_ATCM_PLACEMENT
 .global cp15_enable_atcm
    .thumb_func

cp15_enable_atcm:

    MRC p15,0,r1,c9,c1,1
    LDR r2, =TCM_BADDR_MASK
    AND r1,r1,r2
    ORR r0,r0,#C9_ENABLE_BIT
    ORR r0,r0,r1
    MCR p15,0,r0,c9,c1,1

    BX lr

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
@BOOL cp15_mpu_set_rgn_index(num)
@{
    CP15_MPU_SET_RGN_INDEX_PLACEMENT
 .global cp15_mpu_set_rgn_index
    .thumb_func

cp15_mpu_set_rgn_index:

    LDR r2, =MPU_RGNNUM_MASK
    AND r0,r0,r2
    MCR p15,0,r0,c6,c2,0

    BX lr

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
@BOOL cp15_mpu_set_rgn_addr(addr)
@{
    CP15_MPU_SET_RGN_ADDR_PLACEMENT
 .global cp15_mpu_set_rgn_addr
    .thumb_func

cp15_mpu_set_rgn_addr:

    MRC p15,0,r1,c6,c1,0
    LDR r2, =MPU_BADDR_MASK
    AND r1,r1,r2
    ORR r0,r0,r1
    MCR p15,0,r0,c6,c1,0

    BX lr

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
@BOOL cp15_mpu_set_rgn_accctrl(UINT32 acctrl)
@{
    CP15_MPU_SET_RGN_ACCCTRL_PLACEMENT
 .global cp15_mpu_set_rgn_accctrl
    .thumb_func

cp15_mpu_set_rgn_accctrl:

    MRC p15,0,r1,c6,c1,4
    LDR r2, =MPU_ACCTRL_MASK
    AND r1,r1,r2
    ORR r1,r1,r0
    ISB
    MCR p15,0,r1,c6,c1,4


    BX lr

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
@BOOL cp15_mpu_set_rgn_size(UINT32 size)
@{
    CP15_MPU_SET_RGN_SIZE_PLACEMENT
 .global cp15_mpu_set_rgn_size
    .thumb_func

cp15_mpu_set_rgn_size:

    MRC p15,0,r1,c6,c1,2
    LDR r2, =MPU_SIZE_MASK
    AND r1,r1,r2
    ORR r1,r1,r0,LSL #1
    MCR p15,0,r1,c6,c1,2


    BX lr

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
@BOOL cp15_mpu_set_rgn_enable(UINT32 en)
@{
    CP15_MPU_SET_RGN_ENABLE_PLACEMENT
 .global cp15_mpu_set_rgn_enable
    .thumb_func

cp15_mpu_set_rgn_enable:
    AND r0, #C9_ENABLE_BIT
    CMP r0, #C9_ENABLE_BIT
    MRC p15,0,r1,c6,c1,2
    ORREQ r1,r0,r1
    BICNE r1,r1,#C9_ENABLE_BIT
    MCR p15,0,r1,c6,c1,2

    BX lr

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
    CP15_MPU_SET_SUBREGION_DISABLE_PLACEMENT
 .global cp15_mpu_set_subregion_disable
    .thumb_func

cp15_mpu_set_subregion_disable:
    MRC p15,0,r1,c6,c1,2
    LDR r2, =MPU_SUBREGION_MASK
    AND r1,r1,r2
    MOV r0,r0,LSL #8
    ORR r1,r1,r0
    MCR p15,0,r1,c6,c1,2

    BX lr

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
@VOID cp15_enable_icache(VOID)
@{
    CP15_ENABLE_ICACHE_PLACEMENT
 .global cp15_enable_icache
    .thumb_func

cp15_enable_icache:
    MRC p15, 0, r0, c1, c0, 0
    ORR r0,r0,#C1_IBIT
    MOV r1,#0
    MCR p15, 0, r1, c7, c5, 0 @Invalidate I-Cache
    MCR p15, 0, r0, c1, c0, 0
    ISB

    BX lr

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
@VOID cp15_disable_icache(VOID)
@{
    CP15_DISABLE_ICACHE_PLACEMENT
 .global cp15_disable_icache
    .thumb_func

cp15_disable_icache:

    MRC p15,0,r0,c1,c0,0
    BIC r0,r0,#C1_IBIT
    MCR p15,0,r0,c1,c0,0

    ISB

    BX lr
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
@VOID cp15_data_synchronization_barrier(void)
@{
    CP15_DATA_SYNCHRONIZATION_BARRIER_PLACEMENT
 .global cp15_data_synchronization_barrier
    .thumb_func

cp15_data_synchronization_barrier:

    DSB

    BX lr
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
@VOID cp15_inst_synchronization_barrier(void)
@{
    CP15_INST_SYNCHRONIZATION_BARRIER_PLACEMENT
 .global cp15_inst_synchronization_barrier
    .thumb_func

cp15_inst_synchronization_barrier:

    ISB

    BX lr
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
@VOID cp15_invalidate_icache(VOID)
@{
    CP15_INVALIDATE_ICACHE_PLACEMENT
 .global cp15_invalidate_icache
    .thumb_func

cp15_invalidate_icache:

    MOV r0,#0
    MCR p15,0,r0,c7,c5,0

    BX lr

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
@VOID cp15_invalidate_icache_single(UINT32 MVA)
@{
    CP15_INVALIDATE_ICACHE_SINGLE_PLACEMENT
 .global cp15_invalidate_icache_single
    .thumb_func

cp15_invalidate_icache_single:

@
    MOV r0,r0,LSR #5
    MOV r0,r0,LSL #5
    MCR p15,0,r0,c7,c5,1

    BX lr
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
@VOID cp15_invalidate_icache_region(UINT32 addr, UINT32 nr_cache)
@{
    CP15_INVALIDATE_ICACHE_REGION_PLACEMENT
 .global cp15_invalidate_icache_region
    .thumb_func

cp15_invalidate_icache_region:

    CMP r1,#0
    BEQ invalidate_icache_end

invalidate_icache_begin:
    MCR p15,0,r0,c7,c5,1
    ADD r0,r0,#32
    SUBS r1,r1,#1
    BNE invalidate_icache_begin

invalidate_icache_end:
    BX lr
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
@BOOL cp15_is_icache_enabled(VOID)
@{
    CP15_IS_ICACHE_ENABLED_PLACEMENT
 .global cp15_is_icache_enabled
    .thumb_func

cp15_is_icache_enabled:

    MRC p15, 0, a4, c1, c0, 0
    ANDS a1, a4, #ICACHE_ENABLE
    MOVNE a1, #1

    BX lr
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
@VOID cp15_drain_write_buffer(VOID)
@{
    CP15_DRAIN_WRITE_BUFFER_PLACEMENT
 .global cp15_drain_write_buffer
    .thumb_func

cp15_drain_write_buffer:

    DSB

    BX lr
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
@VOID cp15_enable_dcache(VOID)
@{
    CP15_ENABLE_DCACHE_PLACEMENT
 .global cp15_enable_dcache
    .thumb_func

cp15_enable_dcache:

    MOV r1,#0
    MRC p15,0,r0,c1,c0,0
    ORR r0,r0,#C1_CBIT
    DSB
    MCR p15, 0, r1, c15, c5, 0 @ Invalidate entire data cache
    MCR p15, 0, r0, c1, c0, 0

    BX lr
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
@VOID cp15_disable_dcache(VOID)
@{
    CP15_DISABLE_DCACHE_PLACEMENT
 .global cp15_disable_dcache
    .thumb_func

cp15_disable_dcache:

    MRC p15,0,r0,c1,c0,0
    BIC r0,r0,#C1_CBIT
    DSB
    MCR p15,0,r0,c1,c0,0

    BX lr
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
@VOID cp15_invalidate_dcache(VOID)
@{
    CP15_INVALIDATE_DCACHE_PLACEMENT
 .global cp15_invalidate_dcache
    .thumb_func

cp15_invalidate_dcache:

    MOV r0,#0
    MCR p15,0,r0,c15,c5,0

    BX lr

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
@VOID cp15_invalidate_dcache_single(UINT32 MVA)
@{
    CP15_INVALIDATE_DCACHE_SINGLE_PLACEMENT
 .global cp15_invalidate_dcache_single
    .thumb_func

cp15_invalidate_dcache_single:

@
    MOV r0,r0,LSR #5
    MOV r0,r0,LSL #5
    MCR p15,0,r0,c7,c6,1

    BX lr
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
@VOID cp15_clean_dcache_single(UINT32 MVA)
@{
    CP15_CLEAN_DCACHE_SINGLE_PLACEMENT
 .global cp15_clean_dcache_single
    .thumb_func

cp15_clean_dcache_single:

@
    MOV r0,r0,LSR #5
    MOV r0,r0,LSL #5
    MCR p15,0,r0,c7,c10,1

    BX lr
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
@VOID cp15_invalidate_dcache_region(UINT32 addr, UINT32 nr_cache)
@{
    CP15_INVALIDATE_DCACHE_REGION_PLACEMENT
 .global cp15_invalidate_dcache_region
    .thumb_func

cp15_invalidate_dcache_region:
    CMP r1,#0
    BEQ invalidate_dcache_end

    @ If region > cache size, do invalidate and clean all to improve responsiveness
    LDR r2,=cache_line_nr
    LDR r2,[r2]

    CMP r1,r2
    LDR r3, =cp15_clean_and_invalidate_all_dcache_by_setway
    BXGT r3

invalidate_dcache_begin:
    MCR p15,0,r0,c7,c6,1
    ADD r0,r0,#32
    SUBS r1,r1,#1
    BNE invalidate_dcache_begin

invalidate_dcache_end:
    BX lr
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
@VOID cp15_clean_dcache_region(UINT32 addr, UINT32 nr_cache)
@{
    CP15_CLEAN_DCACHE_REGION_PLACEMENT
 .global cp15_clean_dcache_region
    .thumb_func

cp15_clean_dcache_region:
    CMP r1,#0
    BEQ clean_dcache_end

    @ If the target region > cache size, clean all DCache to improve the response time
    LDR r2,=cache_line_nr
    LDR r2,[r2]

    CMP r1,r2
    LDR r3, =cp15_clean_all_dcache_by_setway
    BXGT r3

clean_dcache_begin:
    MCR p15,0,r0,c7,c10,1
    ADD r0,r0,#32
    SUBS r1,r1,#1
    BNE clean_dcache_begin

clean_dcache_end:
    BX lr
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
    CP15_CLEAN_AND_INVALIDATE_DCACHE_REGION_PLACEMENT
    .global cp15_clean_and_invalidate_dcache_region
    .thumb_func

cp15_clean_and_invalidate_dcache_region:

    CMP r1,#0
    BEQ clean_and_invalidate_dcache_end

    @ If region > cache size, do invalidate and clean all to improve responsiveness
    LDR r2,=cache_line_nr
    LDR r2,[r2]

    CMP r1,r2
    LDR r3, =cp15_clean_and_invalidate_all_dcache_by_setway
    BXGT r3

clean_and_invalidate_dcache_begin:
    MCR p15,0,r0,c7,c14,1
    ADD r0,r0,#32
    SUBS r1,r1,#1
    BNE clean_and_invalidate_dcache_begin

clean_and_invalidate_dcache_end:
    BX lr


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
@VOID cp15_clean_dcache(VOID)
@{
    CP15_CLEAN_DCACHE_PLACEMENT
    .global cp15_clean_dcache
    .thumb_func

cp15_clean_dcache:

    MRC p15, 1, r0, c0, c0, 0 @ read current cache size identification register
    LDR r1 , =NUM_OF_SET_MASK
    AND r0 , r0, r1
    MOV r0 , r0, LSR #NUM_OF_SET_OFFSET

clean_loop:
    MOV r1, #0
    MOV r2, r1, LSL #30
    ORR r2, r2, r0, LSL #5
    MCR p15, 0, r2, c7, c10, 2

    ADD r1, r1, #1
    MOV r2, r1, LSL #30
    ORR r2, r2, r0, LSL #5
    MCR p15, 0, r2, c7, c10, 2

    ADD r1, r1, #1
    MOV r2, r1, LSL #30
    ORR r2, r2, r0, LSL #5
    MCR p15, 0, r2, c7, c10, 2

    ADD r1, r1, #1
    MOV r2, r1, LSL #30
    ORR r2, r2, r0, LSL #5
    MCR p15, 0, r2, c7, c10, 2

    SUBS r0, r0, #1
    BCS clean_loop

    BX lr

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
@BOOL cp15_is_dcache_enabled(VOID)
@{
    CP15_IS_DCACHE_ENABLED_PLACEMENT
    .global cp15_is_dcache_enabled
    .thumb_func

cp15_is_dcache_enabled:

    MRC p15, 0, a4, c1, c0, 0
    ANDS a1, a4, #DCACHE_ENABLE
    MOVNE a1, #1

    BX lr
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
    CP15_CLEAN_AND_INVALIDATE_DCACHE_BY_SETWAY_PLACEMENT
    .global cp15_clean_and_invalidate_dcache_by_setway
    .thumb_func

cp15_clean_and_invalidate_dcache_by_setway:
    LSL r1,r1,#30
    LSL r0,r0,#5
    ORR r0,r0,r1
    MCR p15,0,r0,c7,c14,2 @ Clean/Invalidate set way
    MOV r0,#0

    BX lr

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
@VOID cp15_clean_all_dcache_by_setway(void)
@{
    CP15_CLEAN_ALL_DCACHE_BY_SETWAY_PLACEMENT
    .global cp15_clean_all_dcache_by_setway
    .thumb_func

cp15_clean_all_dcache_by_setway:

    MOV r2,#0xC0000000 @ the way number

clean_all_dcache_init:
    LDR r1,=cache_line_nr_per_way
    LDR r1,[r1] @ total cache number in the way
    MOV r0,r2 @ start address of the way

clean_all_dcache_begin:
    MCR p15,0,r0,c7,c10,2
    ADD r0,r0,#32
    SUBS r1,r1,#1
    BNE clean_all_dcache_begin

    CMP r2,#0
    BEQ clean_all_dcache_end

    SUBS r2,r2,#0x40000000
    B clean_all_dcache_init

clean_all_dcache_end:

    BX lr
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
    CP15_CLEAN_AND_INVALIDATE_ALL_DCACHE_BY_SETWAY_PLACEMENT
    .global cp15_clean_and_invalidate_all_dcache_by_setway
    .thumb_func

cp15_clean_and_invalidate_all_dcache_by_setway:
    MOV r2,#0xC0000000 @ the way number

clean_invalidate_all_dcache_init:
    LDR r1,=cache_line_nr_per_way
    LDR r1,[r1] @ total cache number in the way
    MOV r0,r2 @ start address of the way

clean_invalidate_all_dcache_begin:
    MCR p15,0,r0,c7,c14,2
    ADD r0,r0,#32
    SUBS r1,r1,#1
    BNE clean_invalidate_all_dcache_begin

    CMP r2,#0
    BEQ clean_invalidate_all_dcache_end

    SUBS r2,r2,#0x40000000
    B clean_invalidate_all_dcache_init

clean_invalidate_all_dcache_end:

    BX lr

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
@UINT32 cp15_read_dfsr(VOID)
@{
    CP15_READ_DFSR_PLACEMENT
    .global cp15_read_dfsr
    .thumb_func

cp15_read_dfsr:

    MRC p15,0,r0,c5,c0,0

    BX lr
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
@UINT32 cp15_read_far(VOID)
@{
    CP15_READ_FAR_PLACEMENT
    .global cp15_read_far
    .thumb_func

cp15_read_far:

    MRC p15,0,r0,c6,c0,0

    BX lr
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
@UINT32 cp15_read_ifsr(VOID)
@{
    CP15_READ_IFSR_PLACEMENT
    .global cp15_read_ifsr
    .thumb_func

cp15_read_ifsr:

    MRC p15,0,r0,c5,c0,1

    BX lr
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
@UINT32 cp15_read_ifar(VOID)
@{
    CP15_READ_IFAR_PLACEMENT
    .global cp15_read_ifar
    .thumb_func

cp15_read_ifar:

    MRC p15,0,r0,c6,c0,2

    BX lr
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
@VOID cp15_enter_low_pwr_state(VOID)
@{
    CP15_ENTER_LOW_PWR_STATE_PLACEMENT
    .global cp15_enter_low_pwr_state
    .thumb_func

cp15_enter_low_pwr_state:

    DSB
    WFI
    DSB

    BX lr
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
@VOID cp15_disable_atcmrmw(void)
@{
    CP15_DISABLE_ATCMRMW_PLACEMENT
    .global cp15_disable_atcmrmw
    .thumb_func

cp15_disable_atcmrmw:

    MRC p15,0,r0,c15,c0,0
    BIC r0,r0,#C15_ATCMRMW_MASK
    MCR p15,0,r0,c15,c0,0

    BX lr
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
@VOID cp15_disable_btcmrmw(void)
@{
    CP15_DISABLE_BTCMRMW_PLACEMENT
    .global cp15_disable_btcmrmw
    .thumb_func

cp15_disable_btcmrmw:

    MRC p15,0,r0,c15,c0,0
    BIC r0,r0,#C15_BTCMRMW_MASK
    MCR p15,0,r0,c15,c0,0

    BX lr
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
@VOID cp15_disable_LIL_STLDM(void)
@{
    CP15_DISABLE_LIL_STLDM_PLACEMENT
    .global cp15_disable_LIL_STLDM
    .thumb_func

cp15_disable_LIL_STLDM:

    MRC p15,0,r0,c1,c0,1
    ORR r0,r0,#C1_DILSM_BIT
    MCR p15,0,r0,c1,c0,1

    BX lr

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
@VOID cp15_enable_undef_div_by_zero(void)
@{
    CP15_ENABLE_UNDEF_DIV_BY_ZERO_PLACEMENT
    .global cp15_enable_undef_div_by_zero
    .thumb_func

cp15_enable_undef_div_by_zero:

    MRC p15,0,r0,c1,c0,0
    ORR r0,r0,#C1_DZ_BIT
    MCR p15,0,r0,c1,c0,0

    BX lr

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
@VOID cp15_mpu_get_rbar(void)
@{
    CP15_MPU_GET_RBAR_PLACEMENT
    .global cp15_mpu_get_rbar
    .thumb_func

cp15_mpu_get_rbar:
    MRC p15,0,r0,c6,c1,0

    BX lr
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
@VOID cp15_mpu_get_racr(void)
@{
    CP15_MPU_GET_RACR_PLACEMENT
    .global cp15_mpu_get_racr
    .thumb_func

cp15_mpu_get_racr:
    MRC p15,0,r0,c6,c1,4

    BX lr
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
@VOID cp15_mpu_get_rser(void)
@{
    CP15_MPU_GET_RSER_PLACEMENT
    .global cp15_mpu_get_rser
    .thumb_func

cp15_mpu_get_rser:
    MRC p15,0,r0,c6,c1,2

    BX lr
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
@VOID cp15_data_memory_barrier(VOID)
@{
    CP15_DATA_MEMORY_BARRIER_PLACEMENT
    .global cp15_data_memory_barrier
    .thumb_func

cp15_data_memory_barrier:
    MOV r0, #0
    MCR p15,0,r0,c7,c10,5

    BX lr
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
@VOID cp15_switch_vector(bool)
@{
    CP15_SWITCH_VECTOR_PLACEMENT
    .global cp15_switch_vector
    .thumb_func

cp15_switch_vector:
    CMP r0,#0
    MRC p15,0,r0,c1,c0,0
    ORRNE r0,r0,#C1_VBIT_MASK
    BICEQ r0,r0,#C1_VBIT_MASK
    MCR p15,0,r0,c1,c0,0

    BX lr
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
@VOID cp15_set_bp_policy(bool)
@{
    CP15_SET_BP_POLICY_PLACEMENT
    .global cp15_set_bp_policy
    .thumb_func

cp15_set_bp_policy:
    MRC p15,0,r1,c1,c0,1
    AND r1,r1,#BP_MASK
    ORR r1,r1,r0, LSL #15
    MCR p15,0,r1,c1,c0,1

    BX lr
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
@VOID cp15_switch_vector(bool)
@{
    CP15_READ_ICACHE_INFO_PLACEMENT
    .global cp15_read_icache_info
    .thumb_func

cp15_read_icache_info:
    MRC p15, 2, r0, c0, c0, 0 @ Select instruction cache info
    ORR r0,r0,#C1_CSSELR_InD_BIT @ Select instruction cache info
    MCR p15, 2, r0, c0, c0, 0 @ Select instruction cache info
    MRC p15, 1, r0, c0, c0, 0 @ Read CCIDR

    BX lr
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
@VOID cp15_switch_vector(bool)
@{
    CP15_READ_DCACHE_INFO_PLACEMENT
    .global cp15_read_dcache_info
    .thumb_func

cp15_read_dcache_info:
    MRC p15, 2, r0, c0, c0, 0 @ Select instruction cache info
    BIC r0,r0,#C1_CSSELR_InD_BIT @ Select instruction cache info
    MCR p15, 2, r0, c0, c0, 0 @ Select instruction cache info
    MRC p15, 1, r0, c0, c0, 0 @ Read CCIDR

    BX lr
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
@VOID cp15_write_context_id(kal_uint32)
@{
    CP15_WRITE_CONTEXT_ID_PLACEMENT
    .global cp15_write_context_id
    .thumb_func

cp15_write_context_id:
    MCR p15,0,r0,c13,c0,1
    BX lr

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
@kal_uint32 cp15_read_context_id(void)
@{
    CP15_READ_CONTEXT_ID_PLACEMENT
    .global cp15_read_context_id
    .thumb_func

cp15_read_context_id:
    MRC p15,0,r0,c13,c0,1
    BX lr

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
@kal_uint32 cp15_vector_interrupt_enable(void)
@{
    CP15_VECTOR_INTERRUPT_ENABLE_PLACEMENT
    .global cp15_vector_interrupt_enable
    .thumb_func

cp15_vector_interrupt_enable:

    MRC p15, 0, r0, c1, c0, 0
 BIC r0, r0, #C1_VINITHI @ Vector base = 0x0
 ORRS r0, #C1_VE
    MCR p15, 0, r0, c1, c0, 0

    BX lr

@}

@
@ * Performance Monitor APIs -->
@ **************************************************************************/
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
@kal_uint32 cp15_PMU_read_control_register(void)
@{
    CP15_PMU_READ_CONTROL_REGISTER_PLACEMENT
    .global cp15_PMU_read_control_register
    .thumb_func

cp15_PMU_read_control_register:
    MRC p15,0,r0,c9,c12,0

    BX lr
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
@void cp15_PMU_write_control_register(kal_uint32)
@{
    CP15_PMU_WRITE_CONTROL_REGISTER_PLACEMENT
    .global cp15_PMU_write_control_register
    .thumb_func

cp15_PMU_write_control_register:
    MCR p15,0,r0,c9,c12,0

    BX lr
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
@void cp15_PMU_write_counter_enable_set(kal_uint32)
@{
    CP15_PMU_WRITE_COUNTER_ENABLE_SET_PLACEMENT
    .global cp15_PMU_write_counter_enable_set
    .thumb_func

cp15_PMU_write_counter_enable_set:
    MCR p15,0,r0,c9,c12,1

    BX lr
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
@void cp15_PMU_read_counter_enable_set(kal_uint32)
@{
    CP15_PMU_READ_COUNTER_ENABLE_SET_PLACEMENT
    .global cp15_PMU_read_counter_enable_set
    .thumb_func

cp15_PMU_read_counter_enable_set:
    MRC p15,0,r0,c9,c12,1

    BX lr
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
@void cp15_PMU_write_counter_enable_clear(kal_uint32)
@{
    CP15_PMU_WRITE_COUNTER_ENABLE_CLEAR_PLACEMENT
    .global cp15_PMU_write_counter_enable_clear
    .thumb_func

cp15_PMU_write_counter_enable_clear:
    MCR p15,0,r0,c9,c12,2

    BX lr
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
@kal_uint32 cp15_PMU_write_counter_enable_clear(void)
@{
    CP15_PMU_READ_COUNTER_OVERFLOW_STATUS_PLACEMENT
    .global cp15_PMU_read_counter_overflow_status
    .thumb_func

cp15_PMU_read_counter_overflow_status:
    MRC p15,0,r0,c9,c12,3

    BX lr
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
@void cp15_PMU_read_cycle_counter(kal_uint32, kal_uint32)
@{
    CP15_PMU_WRITE_EVENT_SELECTION_PLACEMENT
    .global cp15_PMU_write_event_selection
    .thumb_func

cp15_PMU_write_event_selection:
    MCR p15,0,r0,c9,c12,5 @ Counter selection
    MCR p15,0,r1,c9,c13,1 @ Event selection

    BX lr
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
@kal_uint32 cp15_PMU_read_cycle_counter(void)
@{
    CP15_PMU_READ_CYCLE_COUNTER_PLACEMENT
    .global cp15_PMU_read_cycle_counter
    .thumb_func

cp15_PMU_read_cycle_counter:
    MRC p15,0,r0,c9,c13,0

    BX lr
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
@void cp15_PMU_write_cycle_counter(kal_uint32)
@{
    CP15_PMU_WRITE_CYCLE_COUNTER_PLACEMENT
    .global cp15_PMU_write_cycle_counter
    .thumb_func

cp15_PMU_write_cycle_counter:
    MCR p15,0,r0,c9,c13,0

    BX lr
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
@kal_uint32 cp15_PMU_read_cycle_counter(void)
@{
    CP15_PMU_READ_EVENT_COUNTER_PLACEMENT
    .global cp15_PMU_read_event_counter
    .thumb_func

cp15_PMU_read_event_counter:
    MCR p15,0,r0,c9,c12,5 @ Counter selection
    MRC p15,0,r0,c9,c13,2 @ Event counter value

    BX lr
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
@void cp15_PMU_read_cycle_counter(kal_uint32, kal_uint32)
@{
    CP15_PMU_WRITE_EVENT_COUNTER_PLACEMENT
    .global cp15_PMU_write_event_counter
    .thumb_func

cp15_PMU_write_event_counter:
    MCR p15,0,r0,c9,c12,5 @ Counter selection
    MCR p15,0,r1,c9,c13,2 @ Event counter value

    BX lr
@}

@
@ * Performance Monitor APIs <--
@ **************************************************************************/
# 199 "driver/sys_drv/cache/src/cp15_gcc.S" 2






    .end
