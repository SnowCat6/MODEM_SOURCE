#include "kal_public_api.h"
#if defined(__MTK_TARGET__)
__attribute__ ((section ("RELEASE_VERNO_RW"))) static kal_char verno_str[] = "MOLY.LR9.W1444.MD.LWTG.MP.V110.5.P1";
__attribute__ ((section ("BUILD_TIME_RW"))) static kal_char build_date_time_str[] = "2016/11/02 18:08";
__attribute__ ((section ("RELEASE_BRANCH_RW"))) static kal_char build_branch_str[] = "LR9.W1444.MD.LWTG.MP HCT6737M_65_N";
extern kal_uint32 RELEASE_VERNO_RW$$Base;
extern kal_uint32 BUILD_TIME_RW$$Base;
extern kal_uint32 RELEASE_BRANCH_RW$$Base;
#endif

kal_char* release_verno(void)
{
#if defined(__MTK_TARGET__)
#if defined(__GNUC__)
   return verno_str;
#else
   return (kal_char*)&RELEASE_VERNO_RW$$Base;
#endif
#else
   static kal_char verno_str[] = "MOLY.LR9.W1444.MD.LWTG.MP.V110.5.P1";
   return verno_str;
#endif
}

kal_char* release_hal_verno(void)
{
   static kal_char hal_verno_str[] = "";
   return hal_verno_str;
}

kal_char* release_hw_ver(void)
{
   static kal_char hw_ver_str[] = "HCT6737M_65_N_HW";
   return hw_ver_str;
}

kal_char* build_date_time(void)
{
#if defined(__MTK_TARGET__)
#if defined(__GNUC__)
   return build_date_time_str;
#else
   return (kal_char*)&BUILD_TIME_RW$$Base;
#endif
#else
   static kal_char build_date_time_str[] = "2016/11/02 18:08";
   return build_date_time_str;
#endif
}

kal_char* release_build(void)
{
   static kal_char build_str[] = "BUILD_NO";
   return build_str;
}

kal_char* release_branch(void)
{
#if defined(__MTK_TARGET__)
#if defined(__GNUC__)
   return build_branch_str;
#else
   return (kal_char*)&RELEASE_BRANCH_RW$$Base;
#endif
#else
   static kal_char build_branch_str[] = "LR9.W1444.MD.LWTG.MP HCT6737M_65_N";
   return build_branch_str;
#endif
}

kal_char* release_flavor(void)
{
   static kal_char build_flavor_str[] = "LWG_DSDS";
   return build_flavor_str;
}

