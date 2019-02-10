/*****************************************************************************
*  Copyright Statement:
*  --------------------
*  This software is protected by Copyright and the information contained
*  herein is confidential. The software may not be copied and the information
*  contained herein may not be used or disclosed except with the written
*  permission of MediaTek Inc. (C) 2006
*
*  BY OPENING THIS FILE, BUYER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
*  THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
*  RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO BUYER ON
*  AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
*  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
*  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
*  NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
*  SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
*  SUPPLIED WITH THE MEDIATEK SOFTWARE, AND BUYER AGREES TO LOOK ONLY TO SUCH
*  THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. MEDIATEK SHALL ALSO
*  NOT BE RESPONSIBLE FOR ANY MEDIATEK SOFTWARE RELEASES MADE TO BUYER'S
*  SPECIFICATION OR TO CONFORM TO A PARTICULAR STANDARD OR OPEN FORUM.
*
*  BUYER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND CUMULATIVE
*  LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
*  AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
*  OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY BUYER TO
*  MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
*
*  THE TRANSACTION CONTEMPLATED HEREUNDER SHALL BE CONSTRUED IN ACCORDANCE
*  WITH THE LAWS OF THE STATE OF CALIFORNIA, USA, EXCLUDING ITS CONFLICT OF
*  LAWS PRINCIPLES.  ANY DISPUTES, CONTROVERSIES OR CLAIMS ARISING THEREOF AND
*  RELATED THERETO SHALL BE SETTLED BY ARBITRATION IN SAN FRANCISCO, CA, UNDER
*  THE RULES OF THE INTERNATIONAL CHAMBER OF COMMERCE (ICC).
*
*****************************************************************************/

/*****************************************************************************
 *
 * Filename:
 * ---------
 *   custom_scatstruct.c
 *
 * Project:
 * --------
 *   Maui_Software
 *
 * Description:
 * ------------
 *   This file provides the scatter file dependent APIs
 *
 * Author:
 * -------
 *   Claudia Lo (mtk01876)     system auto generator m0.26_MOLY + sysGenUtility m0.39 from MOLY
 * 
 *============================================================================
 *             HISTORY
 * Below this line, this part is controlled by PVCS VM. DO NOT MODIFY!!
 *------------------------------------------------------------------------------
 * $Revision$
 * $Modtime$
 * $Log$
 *
 * 12 16 2014 carl.kao
 *  [Denali-1] [SystemService][Auto-Gen] Refactor AutoGen Code and Remove Legacy Code
 * .
 *
 * 02 25 2014 qmei.yang
 *  [SystemService][Auto-Gen][Internal Refinement] Remove useless secure region query api
 * .
 *
 * 06 25 2013 qmei.yang
 *  [SystemService][Auto-Gen][Request For Design Change] Support COPRO
 * support COPRO_arm7's L1Cache
 *
 * 04 26 2013 qmei.yang
 *  [SystemService][MOLY] To remove useless input sections by the request
 * support SWLA space as well
 *
 * 04 09 2013 qmei.yang
 *  [SystemService][Auto-Gen][Request For Design Change] Support code integrity for offline SST
 * .
 *
 * 10 31 2012 qmei.yang
 *  [SystemService][Auto-Gen][Request For Design Change][sysgen2] Create new API: custom_get_DSPTXRX_MaxSize()
 * .
 * 
 * 08 27 2012 qmei.yang
 *  [SystemService][Region_Init][Internal Refinement] Support MT6577 region init and remove useless regions and compile option
 * .
 * 
 * 07 26 2012 qmei.yang
 *  [SystemService][Auto-Gen][Internal Refinement] Fix GCC warnings
 * .
 *
 * 05 28 2012 qmei.yang
 *  [SystemService][Auto-Gen][GCC][Internal Refinement] support AutoGen on GCC
 * Support GCC to use attribute instead of pragma
 *
 * 05 10 2012 qmei.yang
 *  [Reason]sync codes between modem_dev and 11B
 * .
 *
 * 04 16 2012 qmei.yang
 *  [SystemService][Auto-Gen][Request For Design Change] Add 3 objs into TCM and put 3 functions to TCM on MT6280
 * add 3 functions to TCM
 *
 * 03 08 2012 qmei.yang
 *  [SystemService][Auto-Gen][Sys Gen][scatGen][Internal Refinement] Phase in AutoGen new flow to support GCC
 * .
 *
 * 02 15 2012 qmei.yang
 *  [SystemService][Auto-Gen][Sys Gen][scatGen][Internal Refinement] Support cmmgen sync with sysgen2
 * Modify custom_query_dump_region() API
 *
 * 02 15 2012 qmei.yang
 *  [SystemService][Auto-Gen][Sys Gen][scatGen][Internal Refinement] Support cmmgen sync with sysgen2
 * Modify custom_query_dump_region() API
 *
 * 01 31 2012 qmei.yang
 *  [SystemService][Auto-Gen][Sys Gen][scatGen][Internal Refinement] Refactory sysgen2.pl
 * .
 *------------------------------------------------------------------------------
 * Upper this line, this part is controlled by PVCS VM. DO NOT MODIFY!!
 *============================================================================
 ****************************************************************************/


#include "kal_general_types.h"
#include "init.h"
#include "cache_sw_int.h"
#include "cache_sw.h"

#ifdef __MTK_TARGET__
extern kal_uint32 custom_get_fat_addr();
extern kal_uint32 custom_get_fat_len();
extern void AliceGetCompressedDumpRegion(kal_uint32 *base, kal_uint32 *length);
extern kal_uint32 INT_RetrieveFlashBaseAddr(void);
/*******************************************************************************
 * Define import global data.
 *******************************************************************************/

extern kal_uint32 Image$$ROM$$Base;
extern kal_uint32 Image$$ROM$$Length;
extern kal_uint32 Image$$ROM$$ZI$$Limit;
extern kal_uint32 Image$$EMIINIT_CODE$$Base;
extern kal_uint32 Image$$EMIINIT_CODE$$Length;
extern kal_uint32 Image$$EMIINIT_CODE$$ZI$$Limit;
extern kal_uint32 Image$$INTSRAM_CODE$$Base;
extern kal_uint32 Image$$INTSRAM_CODE$$Length;
extern kal_uint32 Image$$INTSRAM_CODE$$ZI$$Limit;
extern kal_uint32 Image$$INTSRAM_DATA$$Base;
extern kal_uint32 Image$$INTSRAM_DATA$$Length;
extern kal_uint32 Image$$INTSRAM_DATA$$ZI$$Limit;
extern kal_uint32 Image$$INTSRAM_PHYSICAL_BOUNDARY$$Base;
extern kal_uint32 Image$$INTSRAM_PHYSICAL_BOUNDARY$$Length;
extern kal_uint32 Image$$INTSRAM_PHYSICAL_BOUNDARY$$ZI$$Limit;
extern kal_uint32 Image$$EXTSRAM$$Base;
extern kal_uint32 Image$$EXTSRAM$$Length;
extern kal_uint32 Image$$EXTSRAM$$ZI$$Limit;
extern kal_uint32 Image$$EXTSRAM_ZI$$Base;
extern kal_uint32 Image$$EXTSRAM_ZI$$Length;
extern kal_uint32 Image$$EXTSRAM_ZI$$ZI$$Limit;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_ZI$$Base;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_ZI$$Length;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_ZI$$ZI$$Limit;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_RW$$Base;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_RW$$Length;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_RW$$ZI$$Limit;
extern kal_uint32 Image$$CACHED_EXTSRAM$$Base;
extern kal_uint32 Image$$CACHED_EXTSRAM$$Length;
extern kal_uint32 Image$$CACHED_EXTSRAM$$ZI$$Limit;
extern kal_uint32 Image$$CACHED_EXTSRAM_PREINIT_ZI$$Base;
extern kal_uint32 Image$$CACHED_EXTSRAM_PREINIT_ZI$$Length;
extern kal_uint32 Image$$CACHED_EXTSRAM_PREINIT_ZI$$ZI$$Limit;
extern kal_uint32 Image$$CACHED_EXTSRAM_NVRAM_LTABLE$$Base;
extern kal_uint32 Image$$CACHED_EXTSRAM_NVRAM_LTABLE$$Length;
extern kal_uint32 Image$$CACHED_EXTSRAM_NVRAM_LTABLE$$ZI$$Limit;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_RW$$Base;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_RW$$Length;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_RW$$ZI$$Limit;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_ZI$$Base;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_ZI$$Length;
extern kal_uint32 Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_ZI$$ZI$$Limit;
extern kal_uint32 Image$$CACHED_DUMMY_END$$Base;
extern kal_uint32 Image$$CACHED_DUMMY_END$$Length;
extern kal_uint32 Image$$CACHED_DUMMY_END$$ZI$$Limit;
extern kal_uint32 Image$$EXTSRAM_DSP_TX$$Base;
extern kal_uint32 Image$$EXTSRAM_DSP_TX$$Length;
extern kal_uint32 Image$$EXTSRAM_DSP_TX$$ZI$$Limit;
extern kal_uint32 Image$$EXTSRAM_DSP_RX$$Base;
extern kal_uint32 Image$$EXTSRAM_DSP_RX$$Length;
extern kal_uint32 Image$$EXTSRAM_DSP_RX$$ZI$$Limit;
extern kal_uint32 Image$$KTEST$$Base;
extern kal_uint32 Image$$KTEST$$Length;
extern kal_uint32 Image$$KTEST$$ZI$$Limit;
extern kal_uint32 Image$$DUMP_VECTOR_TABLE$$Base;
extern kal_uint32 Image$$DUMP_VECTOR_TABLE$$Length;
extern kal_uint32 Image$$DUMP_VECTOR_TABLE$$ZI$$Limit;
extern kal_uint32 Load$$KTEST$$Base;



/*******************************************************************************
 * Define import global data.
 *******************************************************************************/

#if defined(__ARM9_MMU__) || defined(__ARM11_MMU__)

/* define pool size for fine page table and coarse page table */
/*     CPT : 1 (TCM) 
 *       + 4 * (number of continous dynamic CACHEABLE default non-cacheable region)
 *       + 4 * (number of continous dynamic CACHEABLE default cacheable region)
 *       + 4 * (number of continous CACHED region)
 *       + 4 * (number of continous CACHED code region)
 *       + 2 * (number of non-cacched EXTSRAM RW region)
 *       + 2 * (number of non-cacched EXTSRAM RO region)
 *       + 1   (DSP_TX DSP_RX ... )
 *       +     (number of ROM - 1)
 *       + 2   (at the beginning and at the end of FAT)
 * */
#if defined(__ARM9_MMU__)
#define MAX_FPT_POOL_SIZE ( 0 )
#define MAX_CPT_POOL_SIZE (23 * 1 * 1024)
#elif defined(__ARM11_MMU__)
#define MAX_CPT_POOL_SIZE ( 23 * 1 * 1024)
#endif /* __ARM11_MMU__ */

#if defined(__ARM9_MMU__)
/* memory pool of fine page table */
#if (MAX_FPT_POOL_SIZE > 0)
__PT_Aligned(4 * 1024) static kal_uint32 FPT_POOL[MAX_FPT_POOL_SIZE / 4];
#endif /* MAX_FPT_POOL_SIZE > 0 */
#endif /* __ARM9_MMU__ */
/* memory pool of coarse page table */
__PT_Aligned(1024) static  kal_uint32 CPT_POOL[MAX_CPT_POOL_SIZE / 4];

#endif /* __ARM9_MMU__ || __ARM11_MMU__ */

#if defined(__DYNAMIC_SWITCH_CACHEABILITY__)

__TCMZI static EXTSRAM_REGION_INFO_T DYNAMIC_CACHED_EXTSRAM_DNC_REGION[2];
__TCMZI static EXTSRAM_REGION_INFO_T DYNAMIC_CACHED_EXTSRAM_DC_REGION[2];
__TCMZI static EXTSRAM_REGION_INFO_T CACHED_EXTSRAM_REGION[2];
__TCMZI static EXTSRAM_REGION_INFO_T CACHED_EXTSRAM_CODE_REGION[1];
__TCMZI static EXTSRAM_REGION_INFO_T NONCACHED_EXTSRAM_REGION[4];
__TCMZI static EXTSRAM_REGION_INFO_T NONCACHED_EXTSRAM_RO_REGION[1];


#endif /* __DYNAMIC_SWITCH_CACHEABILITY__ */

#define SWLA_SIZE 0x40000
#if defined(__SWLA_SELFSPACE_ENABLE__)
__NONCACHEDZI static kal_uint32 EXTSRAM_SWLA[SWLA_SIZE];
#endif //defined(__SWLA_SELFSPACE_ENABLE__)

#if defined(__ARM9_MMU__) || defined(__ARM11_MMU__)
#if defined(__ARM9_MMU__)
/*************************************************************************
* FUNCTION
*  custom_query_fpt_pool
*
* DESCRIPTION
*  This function gets the address and size of fpt pool.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_int32 custom_query_fpt_pool(kal_uint32 **pool, kal_uint32 *pool_size)
{
#if (MAX_FPT_POOL_SIZE > 0)
    *pool = FPT_POOL;
    *pool_size = MAX_FPT_POOL_SIZE;
#else /* MAX_FPT_POOL_SIZE > 0 */
    *pool = NULL;
    *pool_size = 0;
#endif /* MAX_FPT_POOL_SIZE > 0 */

    return 0;
}
#endif /* __ARM9_MMU__ */

/*************************************************************************
* FUNCTION
*  custom_query_cpt_pool
*
* DESCRIPTION
*  This function gets the address and size of cpt pool.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_int32 custom_query_cpt_pool(kal_uint32 **pool, kal_uint32 *pool_size)
{
    *pool = CPT_POOL;
    *pool_size = MAX_CPT_POOL_SIZE;

    return 0;
}

#endif /* __ARM9_MMU__ || __ARM11_MMU__ */

#if defined(__DYNAMIC_SWITCH_CACHEABILITY__)

/************************************************************************
* FUNCTION
*  custom_query_dynamic_cached_extsram_default_nc_region
*
* DESCRIPTION
*  This function gets info of dynamic cached default non-cached EXT SRAM regions.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_int32 custom_query_dynamic_cached_extsram_default_nc_region(EXTSRAM_REGION_INFO_T **region)
{
    *region = DYNAMIC_CACHED_EXTSRAM_DNC_REGION;

    return 0;
}

/************************************************************************
* FUNCTION
*  custom_query_dynamic_cached_extsram_default_c_region
*
* DESCRIPTION
*  This function gets info of dynamic cached default cached EXT SRAM regions.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_int32 custom_query_dynamic_cached_extsram_default_c_region(EXTSRAM_REGION_INFO_T **region)
{
    *region = DYNAMIC_CACHED_EXTSRAM_DC_REGION;

    return 0;
}

/*************************************************************************
* FUNCTION
*  custom_query_cached_extsram_region
*
* DESCRIPTION
*  This function gets info of cached EXT SRAM regions.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_int32 custom_query_cached_extsram_region(EXTSRAM_REGION_INFO_T **region)
{
    *region = CACHED_EXTSRAM_REGION;

    return 0;
}

/*************************************************************************
* FUNCTION
*  custom_query_cached_extsram_code_region
*
* DESCRIPTION
*  This function gets info of cached EXT SRAM code regions.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
__TCMROCODE
kal_int32 custom_query_cached_extsram_code_region(EXTSRAM_REGION_INFO_T **region)
{
    *region = CACHED_EXTSRAM_CODE_REGION;

    return 0;
}

/*************************************************************************
* FUNCTION
*  custom_query_noncached_extsram_region
*
* DESCRIPTION
*  This function gets info of non-cached RW EXT SRAM regions.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
__TCMROCODE
kal_int32 custom_query_noncached_extsram_region(EXTSRAM_REGION_INFO_T **region)
{
    *region = NONCACHED_EXTSRAM_REGION;

    return 0;
}

/*************************************************************************
* FUNCTION
*  custom_query_noncached_extsram_ro_region
*
* DESCRIPTION
*  This function gets info of non-cached RO EXT SRAM regions.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
__TCMROCODE
kal_int32 custom_query_noncached_extsram_ro_region(EXTSRAM_REGION_INFO_T **region)
{
    *region = NONCACHED_EXTSRAM_RO_REGION;

    return 0;
}
#endif /* __DYNAMIC_SWITCH_CACHEABILITY__ */



/*************************************************************************
* FUNCTION
*  custom_get_1st_ROM_ROMBase
*
* DESCRIPTION
*  Retrieve the base address of the 1st ROM (Load View)
*  This function must sync with scatter file structure
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_1st_ROM_ROMBase(void)
{
    return (kal_uint32)&Image$$ROM$$Base;
}

/*************************************************************************
* FUNCTION
*  custom_get_1st_ROM_ROMLength
*
* DESCRIPTION
*  Retrieve the actual ROM length of 1st ROM (Load View)
*  This function must sync with scatter file structure
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_1st_ROM_ROMLength(void)
{
    kal_uint32 ROMLength = 0;
    ROMLength += (kal_uint32)&Image$$ROM$$Length;

    return ROMLength; 
}

/*************************************************************************
* FUNCTION
*  custom_get_1st_ROM_RAMBase
*
* DESCRIPTION
*  Retrieve the RAM base address of the 1st ROM (Load View)
*  This function must sync with scatter file structure
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_1st_ROM_RAMBase(void)
{
    return (kal_uint32)&Image$$EXTSRAM$$Base;
}

/*************************************************************************
* FUNCTION
*  custom_get_1st_ROM_RAMLength
*
* DESCRIPTION
*  Retrieve the actual RAM length of 1st ROM (Load View)
*  This function must sync with scatter file structure
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_1st_ROM_RAMLength(void)
{
    kal_uint32 RAMLength = 0;
    
    return RAMLength; 
}

/*************************************************************************
* FUNCTION
*  custom_get_1st_ROM_RAMEnd
*
* DESCRIPTION
*  Retrieve the actual end address of 1st ROM (Exec View)
*  This function must sync with scatter file structure
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_1st_ROM_RAMEnd(void)
{
    kal_uint32 EndAddr = 0;

    EndAddr  = (kal_uint32)&Image$$EXTSRAM_DSP_RX$$ZI$$Limit;

    return EndAddr; 
}

/*************************************************************************
* FUNCTION
*  custom_get_1st_ROM_LoadEnd
*
* DESCRIPTION
*  Retrieve the actual end address of 1st ROM (Load View)
*  This function must sync with scatter file structure
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_1st_ROM_LoadEnd(void)
{
    kal_uint32 EndAddr = 0;

    EndAddr  = (kal_uint32)&Load$$KTEST$$Base;
    EndAddr += (kal_uint32)&Image$$KTEST$$Length;

    return EndAddr; 
}

/*************************************************************************
* FUNCTION
*  custom_get_INTSRAMCODE_Base
*
* DESCRIPTION
*  Retrieve the base address of INTSRAM_CODE
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_INTSRAMCODE_Base(void)
{
    return (kal_uint32)&Image$$INTSRAM_CODE$$Base;
}

/*************************************************************************
* FUNCTION
*  custom_get_INTSRAMCODE_End
*
* DESCRIPTION
*  Retrieve the END address of INTSRAM_CODE
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_INTSRAMCODE_End(void)
{
    return (kal_uint32)&Image$$INTSRAM_CODE$$ZI$$Limit;
}
/*************************************************************************
* FUNCTION
*  custom_get_INTSRAMDATA_Base
*
* DESCRIPTION
*  Retrieve the base address of INTSRAM_DATA
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_INTSRAMDATA_Base(void)
{
    return (kal_uint32)&Image$$INTSRAM_DATA$$Base;
}

/*************************************************************************
* FUNCTION
*  custom_get_INTSRAMDATA_End
*
* DESCRIPTION
*  Retrieve the END address of INTSRAM_DATA
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_INTSRAMDATA_End(void)
{
    return (kal_uint32)&Image$$INTSRAM_DATA$$ZI$$Limit;
}


#if defined(__CR4__)
/*************************************************************************
* FUNCTION
*  custom_get_INTSRAM_PHYSICAL_BOUNDARY_Base
*
* DESCRIPTION
*  Retrieve the base address of INTSRAM_PHYSICAL_BOUNDARY
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_INTSRAM_PHYSICAL_BOUNDARY_Base(void)
{
    return (kal_uint32)&Image$$INTSRAM_PHYSICAL_BOUNDARY$$Base;
}
/*************************************************************************
* FUNCTION
*  custom_get_INTSRAM_PHYSICAL_BOUNDARY_MaxSize
*
* DESCRIPTION
*  Retrieve the MaxSize of INTSRAM_PHYSICAL_BOUNDARY 
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_INTSRAM_PHYSICAL_BOUNDARY_MaxSize(void)
{
    return 0x40000;
}
#endif /*__CR4__*/

/*************************************************************************
* FUNCTION
*  custom_get_PROTECTED_RES_Base
*
* DESCRIPTION
*  Retrieve the base address of EXTSRAM_PROTECTED_RES
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_int32 custom_get_PROTECTED_RES_Base(void)
{
    return 0;
}

/*************************************************************************
* FUNCTION
*  custom_get_PROTECTED_RES_Length
*
* DESCRIPTION
*  Retrieve the length of EXTSRAM_PROTECTED_RES
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_int32 custom_get_PROTECTED_RES_Length(void)
{
    return 0;
}

/*************************************************************************
* FUNCTION
*  custom_get_BOOTCERT_StartAddr
*
* DESCRIPTION
*  Retrieve the base address of BOOT_CERT
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_BOOTCERT_StartAddr(void)
{
    return 0;
}

/*************************************************************************
* FUNCTION
*  custom_get_BOOTCERT_Length
*
* DESCRIPTION
*  Retrieve the length of BOOT_CERT
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_BOOTCERT_Length(void)
{
    return 0;
}

/*************************************************************************
* FUNCTION
*  custom_get_DSPTXRX_Base
*
* DESCRIPTION
*  Retrieve the lowest base address of DSP_TX or DSP_RX
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_int32 custom_get_DSPTXRX_Base(void)
{
    return (kal_uint32)&Image$$EXTSRAM_DSP_TX$$Base;
}
/*************************************************************************
* FUNCTION
*  custom_get_DSPTXRX_MaxSize
*
* DESCRIPTION
*  Retrieve the reserved size of DSP_TX plus DSP_RX
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_int32 custom_get_DSPTXRX_MaxSize(void)
{
    return 0x20000 + 0x20000;
}

/*************************************************************************
* FUNCTION
*  custom_get_FAT_StartAddr
*
* DESCRIPTION
*  Retrieve FAT base address
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_FAT_StartAddr(void)
{
    return (custom_get_fat_addr() | INT_RetrieveFlashBaseAddr());
}

/*************************************************************************
* FUNCTION
*  custom_get_FAT_Length
*
* DESCRIPTION
*  Retrieve FAT length
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_FAT_Length(void)
{
    return custom_get_fat_len();
}


/*************************************************************************
* FUNCTION
*  custom_get_MaxAvailableMemorySegment
*
* DESCRIPTION
*  Retrieve the pointer (16 Bytes aligned) and the length that unUsed memory segments
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/

void custom_get_MaxAvailableMemorySegment(kal_uint32 **Return_begin_addr, kal_uint32 *Return_segment_size)
{
    kal_uint32  MaxLength;
    kal_uint32  MaxBeginAddr;
    kal_uint32  LastRegionEnd;
    kal_uint32  ThisRegionBegin;

#if defined(__SWLA_SELFSPACE_ENABLE__)
    MaxLength = 4*SWLA_SIZE;
    MaxBeginAddr = (kal_uint32)EXTSRAM_SWLA;
#else //defined(__SWLA_SELFSPACE_ENABLE__)
    MaxLength = 0;
    MaxBeginAddr = 0;

    /* Direct Assign the Cached Region */
    ThisRegionBegin = (kal_uint32)&Image$$CACHED_DUMMY_END$$Base;
    LastRegionEnd   = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_ZI$$ZI$$Limit;
    LastRegionEnd   = (LastRegionEnd + 16) & 0xFFFFFFF0;

    MaxLength       = ThisRegionBegin - LastRegionEnd;
    MaxBeginAddr    = LastRegionEnd;

    /* round to 4KB aligned */
    MaxBeginAddr = ((MaxBeginAddr + 4096 - 1) >> 12) << 12;

    if (MaxLength < 4096) {
        MaxLength = 0;
    } else {
        /* round down to 4KB aligned */
        MaxLength -= 4096;
        /* round up end address to 4KB aligned */
        MaxLength = (MaxLength / 4096) * 4096;
    }

    /* Convert to non-cached address */
#if !defined(MT6290)
    MaxBeginAddr  =  MAP2CREGPA(MaxBeginAddr);
#endif

#endif //defined(__SWLA_SELFSPACE_ENABLE__)
    /* Now we get the maximum segments */
    *Return_begin_addr   = (kal_uint32 *)MaxBeginAddr;
    *Return_segment_size = MaxLength;
}


/*************************************************************************
* FUNCTION
*  custom_mk_ram_info
*
* DESCRIPTION
*  This function builds up EXTSRAM info tables.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
#if defined(__ARM9_MMU__) || defined(__ARM11_MMU__) || defined(__MTK_MMU__) || defined(__CR4__) || defined(__MTK_MMU_V2__)
kal_int32 custom_mk_ram_info()
{
    /* This table contains all dynamic cacheable default non-cacheable regions. */
    DYNAMIC_CACHED_EXTSRAM_DNC_REGION[0].addr = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_ZI$$Base;
    DYNAMIC_CACHED_EXTSRAM_DNC_REGION[0].len = (kal_uint32)((kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_RW$$Base + (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_RW$$Length) - DYNAMIC_CACHED_EXTSRAM_DNC_REGION[0].addr;
    DYNAMIC_CACHED_EXTSRAM_DNC_REGION[1].addr = DYNAMIC_CACHED_EXTSRAM_DNC_REGION[1].len = 0;


    /* This table contains all dynamic cacheable default cacheable regions. */
    DYNAMIC_CACHED_EXTSRAM_DC_REGION[0].addr = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_RW$$Base;
    DYNAMIC_CACHED_EXTSRAM_DC_REGION[0].len = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_ZI$$ZI$$Limit - DYNAMIC_CACHED_EXTSRAM_DC_REGION[0].addr;
    DYNAMIC_CACHED_EXTSRAM_DC_REGION[1].addr = DYNAMIC_CACHED_EXTSRAM_DC_REGION[1].len = 0;


    /* This table contains all cached regions. */
    CACHED_EXTSRAM_REGION[0].addr = (kal_uint32)&Image$$CACHED_EXTSRAM$$Base;
    CACHED_EXTSRAM_REGION[0].len = (kal_uint32)&Image$$CACHED_EXTSRAM_NVRAM_LTABLE$$ZI$$Limit - CACHED_EXTSRAM_REGION[0].addr;
    CACHED_EXTSRAM_REGION[1].addr = CACHED_EXTSRAM_REGION[1].len = 0;


    /* This table contains all cached code regions. */
    CACHED_EXTSRAM_CODE_REGION[0].addr = CACHED_EXTSRAM_CODE_REGION[0].len = 0;


    /* This table contains all non-cached rw regions. */
    NONCACHED_EXTSRAM_REGION[0].addr = (kal_uint32)&Image$$EXTSRAM$$Base;
    NONCACHED_EXTSRAM_REGION[0].len = (kal_uint32)&Image$$EXTSRAM_ZI$$ZI$$Limit - NONCACHED_EXTSRAM_REGION[0].addr;
    NONCACHED_EXTSRAM_REGION[1].addr = (kal_uint32)&Image$$EXTSRAM_DSP_TX$$Base;
    NONCACHED_EXTSRAM_REGION[1].len = 0x20000;
    NONCACHED_EXTSRAM_REGION[2].addr = (kal_uint32)&Image$$EXTSRAM_DSP_RX$$Base;
    NONCACHED_EXTSRAM_REGION[2].len = 0x20000;
    NONCACHED_EXTSRAM_REGION[3].addr = NONCACHED_EXTSRAM_REGION[3].len = 0;


    /* This table contains all non-cached ro regions. */
    NONCACHED_EXTSRAM_RO_REGION[0].addr = NONCACHED_EXTSRAM_RO_REGION[0].len = 0;



    return 0;
}
#endif /* __ARM9_MMU__ || __ARM11_MMU__ || __MTK_MMU__ || __CR4__ || __MTK_MMU_V2__ */


/*************************************************************************
* FUNCTION
*  custom_get_NVRAM_LTABLE_Base
*
* DESCRIPTION
*  Retrieve the base address of NVRAM_LTABLE
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_NVRAM_LTABLE_Base(void)
{
    return (kal_uint32)&Image$$CACHED_EXTSRAM_NVRAM_LTABLE$$Base;
}

/*************************************************************************
* FUNCTION
*  custom_get_NVRAM_LTABLE_Length
*
* DESCRIPTION
*  Retrieve the length of NVRAM_LTABLE
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 custom_get_NVRAM_LTABLE_Length(void)
{
    return (kal_uint32)&Image$$CACHED_EXTSRAM_NVRAM_LTABLE$$Length;
}


/*************************************************************************
* FUNCTION
*  custom_query_dump_region
*
* DESCRIPTION
*  This function builds up the table of DUMP REGIONs.
*
* PARAMETERS
*
* RETURNS
*
*************************************************************************/
kal_uint32 FirstRODumpRegionBase = (kal_uint32)&Image$$ROM$$Base;
kal_uint32 custom_query_dump_region(EXTSRAM_REGION_INFO_T* region)
{
    region[0].addr = 0x0;
    region[0].len = 0x200;
    if( FirstRODumpRegionBase == 0x0)
        region[0].addr += 4;
    region[1].addr = (kal_uint32)&Image$$ROM$$Base;
    region[1].len = (kal_uint32)&Image$$ROM$$ZI$$Limit - region[1].addr;
    region[2].addr = (kal_uint32)&Image$$INTSRAM_CODE$$Base;
    region[2].len = 0x80000;
    region[3].addr = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_ZI$$Base;
    region[3].len = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_RW$$ZI$$Limit - region[3].addr;
    region[4].addr = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_ZI$$Base;
    region[4].len = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_NONCACHEABLE_RW$$ZI$$Limit - region[4].addr;
    region[4].addr = MAP2CREGVA(region[4].addr);
    region[5].addr = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_RW$$Base;
    region[5].len = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_ZI$$ZI$$Limit - region[5].addr;
    region[5].addr = MAP2CREGPA(region[5].addr);
    region[6].addr = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_RW$$Base;
    region[6].len = (kal_uint32)&Image$$DYNAMIC_CACHEABLE_EXTSRAM_DEFAULT_CACHEABLE_ZI$$ZI$$Limit - region[6].addr;
    region[7].addr = (kal_uint32)&Image$$CACHED_EXTSRAM$$Base;
    region[7].len = (kal_uint32)&Image$$CACHED_EXTSRAM_NVRAM_LTABLE$$ZI$$Limit - region[7].addr;
    region[7].addr = MAP2CREGPA(region[7].addr);
    region[8].addr = (kal_uint32)&Image$$CACHED_EXTSRAM$$Base;
    region[8].len = (kal_uint32)&Image$$CACHED_EXTSRAM_NVRAM_LTABLE$$ZI$$Limit - region[8].addr;
    region[9].addr = (kal_uint32)&Image$$EXTSRAM$$Base;
    region[9].len = (kal_uint32)&Image$$EXTSRAM_ZI$$ZI$$Limit - region[9].addr;
    region[10].addr = (kal_uint32)&Image$$EXTSRAM_DSP_TX$$Base;
    region[10].len = 0x20000;
    region[11].addr = (kal_uint32)&Image$$EXTSRAM_DSP_RX$$Base;
    region[11].len = 0x20000;

    return DUMP_REGION_COUNT*2;
}

#endif /* __MTK_TARGET__ */
