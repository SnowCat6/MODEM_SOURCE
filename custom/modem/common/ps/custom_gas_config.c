/*****************************************************************************
*  Copyright Statement:
*  --------------------
*  This software is protected by Copyright and the information contained
*  herein is confidential. The software may not be copied and the information
*  contained herein may not be used or disclosed except with the written
*  permission of MediaTek Inc. (C) 2008
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
/*******************************************************************************
 *
 * Filename:
 * ---------
 * custom_gas_config.c
 *
 * Project:
 * --------
 *   MONZA
 *
 * Description:
 * ------------
 *   This file is used to define the GAS configuration.
 *
 * Author:
 * -------
 * -------
 *
 *==============================================================================
 *             HISTORY
 * Below this line, this part is controlled by PVCS VM. DO NOT MODIFY!!
 *------------------------------------------------------------------------------
 * removed!
 *
 * removed!
 * removed!
 * removed!
 *
 * removed!
 * removed!
 * removed!
 * removed!
 *
 * removed!
 * removed!
 * removed!
 *
 * removed!
 * removed!
 * removed!
 *
 * removed!
 * removed!
 * removed!
 *
 * removed!
 * removed!
 * removed!
 *
 * removed!
 * removed!
 * removed!
 *
 * removed!
 * removed!
 * removed!
 *
 * removed!
 * removed!
 * removed!
 *
 *------------------------------------------------------------------------------
 * Upper this line, this part is controlled by PVCS VM. DO NOT MODIFY!!
 *==============================================================================
 *******************************************************************************/

#include "kal_general_types.h"

/* For customer define the improved call prefer setting, TRUE: enable, FALSE: disable */
#define IMPROVED_CALL_PREFER_SETTING  KAL_TRUE

/* For customer define the L2 fill bits randomization setting, TRUE: enable, FALSE: disable(default setting) */
#define L2_FILL_BITS_RANDOMIZATION_SETTING  KAL_FALSE

/* 20130902 James: at%campreq: search specific channels */
/* The variable of the specific channel searching */
kal_bool gas_custom_specific_channel_srch = KAL_FALSE;

/* The number of specific channels */
#define NUM_OF_SPECIFIC_CHANNELS    16 

/* The specific channels */
kal_uint16 specific_arfcn[NUM_OF_SPECIFIC_CHANNELS] = 
{      1,    2,    3,    4, /* band value 1: gsm900 */
     131,  132,  133,  134, /* band value 2: gsm850 */
    1536, 1537, 1538, 1539, /* band value 3: pcs, need to add PCS tag (value 1024) */
                            /* ex. arfcn 512 of pcs should be 512 + 1024 = 1536    */
     512,  513,  514,  515  /* band value 4: dcs    */
};

/* Customer can set the total number of frequencies which are scanned for full band PLMN search/list. */
kal_uint16 gas_custom_max_arfcn_to_try = 100;

/* Customer can set the number of GSM cells of each GSM band to decode for PLMN search
* or PLMN List procedure. The impact is that the larger the number, the result will be more
* sensative under that environment, but it will spend longer time to finish the procedure.
* Please do not assign each value more than 255.
*/
kal_uint8 gas_custom_max_decoded_cell_a_band[] =
{
    32, /* PGSM900 */
    32, /* EGSM900 */
    32, /* RGSM900 */
    32, /* DCS1800 */
    32, /* PCS1900 */
    32, /* GSM450  */
    32, /* GSM480  */
    32  /* GSM850  */
};

/* rlac threshold in CSFB procedure, when a specific cell's power is above the set value,
 * MS will try to camp on this 2G cell
*/
kal_int16 gas_rlac_threshold_in_CSFB = -90;

/*****************************************************************************
* FUNCTION
*  rr_get_improved_call_prefer_setting
* DESCRIPTION
*   This function is used to define the improved call prefer setting
*   TRUE: enable improved call prefer, FALSE: disable improved call prefer
*
* PARAMETERS
*
* RETURNS
*  kal_bool
* GLOBALS AFFECTED
*   None
*****************************************************************************/
kal_bool rr_get_improved_call_prefer_setting (void)
{
   return (IMPROVED_CALL_PREFER_SETTING);
}


/*****************************************************************************
* FUNCTION
*  rr_get_l2_fill_bits_randomization_setting
* DESCRIPTION
*   This function is used to define the L2 fill bits randomization setting
*   TRUE: enable L2 randomization, FALSE: disable L2 randomization
*
* PARAMETERS
*
* RETURNS
*  kal_bool
* GLOBALS AFFECTED
*   None
*****************************************************************************/
kal_bool rr_get_l2_fill_bits_randomization_setting (void)
{
   return (L2_FILL_BITS_RANDOMIZATION_SETTING);
}

/*****************************************************************************
* FUNCTION
*  gas_custom_is_specific_channel_srch
* DESCRIPTION
*   The function returns whether UE is in specific channel search mode.
*
* PARAMETERS
*  Void
* RETURNS
*  kal_bool
*  TRUE: specific channel search mode, FALSE: normal search mode
* GLOBALS AFFECTED
*   None
*****************************************************************************/
kal_bool gas_custom_is_specific_channel_srch(void)
{
    return gas_custom_specific_channel_srch;
}

/*****************************************************************************
* FUNCTION
*   gas_custom_get_num_of_specific_channels
* DESCRIPTION
*   The function returns the number of specific channels
*
* PARAMETERS
*  Void
* RETURNS
*  kal_unit16 the number of specific channels 
* GLOBALS AFFECTED
*   None
*****************************************************************************/
kal_uint8 gas_custom_get_num_of_specific_channels(void)
{
    if (gas_custom_specific_channel_srch == KAL_TRUE)
    {
        return NUM_OF_SPECIFIC_CHANNELS;
    }
    else
    {
        return 0;
    }
}

/*****************************************************************************
* FUNCTION
*   gas_custom_get_specific_channels
* DESCRIPTION
*   The function returns the number of specific channels
*
* PARAMETERS
*  Void
* RETURNS
*  kal_unit16 the number of specific channels 
* GLOBALS AFFECTED
*   None
*****************************************************************************/
kal_uint16 * gas_custom_get_specific_channels(void)
{
    if (gas_custom_specific_channel_srch == KAL_TRUE)
    {
        return (&(specific_arfcn[0]));
    }
    else
    {
        return NULL;
    }
}

/*****************************************************************************
* FUNCTION
*  as_custom_set_specific_channel_srch
* DESCRIPTION
*   The function set specific search mode.
*
* PARAMETERS
*   kal_bool
*   TRUE: set specific search mode, FALSE: disable specific search mode.
* RETURNS
*   Void
* GLOBALS AFFECTED
*   None
*****************************************************************************/
void gas_custom_set_specific_channel_srch( kal_bool set_value )
{
    gas_custom_specific_channel_srch = set_value;
}

/*****************************************************************************
* FUNCTION
*  as_custom_get_rlac_threshold_in_csfb
* DESCRIPTION
*   The function get rlac threshold in csfb procedure.
*
* PARAMETERS
*   kal_int16 rlac threshold in csfb procedure.
* RETURNS
*   Void
* GLOBALS AFFECTED
*   None
*****************************************************************************/
kal_int16 as_custom_get_rlac_threshold_in_csfb (void)
{
    return gas_rlac_threshold_in_CSFB * 4;
}

#ifdef __A5_3_AND_GEA_WHILTE_LIST__

/*****************************************************************************
* FUNCTION
*  gas_custom_check_plmn_for_a5_gea
* DESCRIPTION
*  This function is for customizing PLMN in the  list, on which gas support A5 algorithms
* 
* PARAMETERS
* plmn_id : the currently camped plmn/plmn in IMSI. the plmn is taken in the form of uint32. Each nibble holds each part of plmn.
*           each nibble in plmn ID stands for: XXXX XXXX===> X->spare(most significant nibble), X->spare, X->mcc1, X->mcc2, X->mcc3, X->mnc1, X->mnc2, X->mnc3(least significant nibble)
*
* a5        The value in this variable is filled bit wise and as per spec 24.008
*           this variable is used to set the a5 algo based on the plmn match. this indicates algo support in bit map format
*             XXXX XXXX => spear bit(MSB), a5/1, a5/2, a5/3, a5/4, a5/5, a5/6,a5/7(LSB)
*            For a51 bit  ==> bit value 0 ==> algo enabled
*                         ==> bit value 1 ==> algo disabled
*            for rest of the algo(a52 to a57)
*             bit value 0 => algo disabled
*             bit value 1 =>  algo enabled
*
* gea       : this variable is used to enable/disable the gea_x algo.
*             XXXX XXXX => spear bit(MSB), gea/1, gea/2, gea/3, gea/4, gea/5, gea/6,gea/7(LSB)
*             when bit value is set as 1, then corresponding gea algo is made enabled
*             when bit value is set as 0, then corresponding gea algo is made disabled
*           
* RETURNS
* plmn_match : if true, then the camped plmn is matched in the list of customer specified plmn
*              if false, then the camped plmn is not matched in the list of customer specified plmn       
* 
* GLOBALS AFFECTED
*   None
*****************************************************************************/
kal_bool gas_custom_check_plmn_for_a5_gea(kal_uint32 plmn_id, kal_uint8 *a5, kal_uint8 *gea )
{
     kal_bool plmn_match = KAL_FALSE;
  
    /* each bit in the uint a5 stands for each a5/x algo as explained in description of function   */

	switch(plmn_id)
    {

	/*Please add  plmn list (as format explained in description )below for enabling and disabling a5/x algorithm */
	
     /*case 0x0046697f: *a5 = 0x60;                  
                      *gea =  0x60;	     
                       plmn_match = KAL_TRUE;
                       break; */  

          default: plmn_match = KAL_FALSE;
                        break; 
    }  	
    
    return plmn_match ;
}

#endif /* __A5_3_AND_GEA_WHILTE_LIST__ */
