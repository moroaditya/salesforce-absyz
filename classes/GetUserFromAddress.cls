public class GetUserFromAddress
{
	   
	public static boolean IsCaribbeanCountry(string country) {

        if (country == 'anguilla' ||country == 'ai' ||
        country == 'antigua and barbuda' || country == 'ag' ||
        country == 'antilles, netherlands' || country == 'ant' ||
        country == 'aruba' || country == 'aw' || 
        country == 'bahamas' || country == 'bs' || 
        country == 'barbados' || country == 'bb' || 
        country == 'bermuda' ||  country == 'bm' ||  
        country == 'british virgin islands' || country == 'vg' || 
        country == 'cayman islands' || country == 'ky' || 
        country == 'haiti' || country == 'ht' ||  
        country == 'jamaica' || country == 'jm' || 
        country == 'trinidad and tobago' || country == 'tt' || 
        country == 'saint kitts and nevis' || country == 'kn' || 
        country == 'dominican republic' || country == 'do' || 
        country == 'dominica' || country == 'dm' || 
        country =='grenada' ||  country =='gd' ||  
        country == 'saint vincent and the grenadines' || country == 'vc' || 
        country == 'turks & caicos' || country == 'tc' )
        {
            return true;
        }
        else return false;
/*        
<option value="AIA">Anguilla</option>
<option value="ATG">Antigua and Barbuda</option>
<option value="ANT">Antilles, Netherlands</option>
<option value="ABW">Aruba</option>
<option value="BHS">Bahamas</option>
<option value="BRB">Barbados</option>
<option value="BMU">Bermuda</option>
<option value="VGB">British Virgin Islands</option>
<option value="CYM">Cayman Islands</option>
<option value="HTI">Haiti</option>
<option value="JAM">Jamaica</option>
<option value="TTO">Trinidad and Tobago</option>
<option value="KNA">Saint Kitts and Nevis</option>
<option value="DOM">Dominican Republic</option>
<option value="DMA">Dominica</option>
<option value="GRD">Grenada</option>
  */      
	}


	public static boolean HasVanNessCommission(string zip)
	{
		if ( BC1(zip) )
			return true;
		else return false;
	}
	
	public static boolean  BC1( string zip)
	{
		if ( zip.startsWith('v') )
		{
			if ( !(
					zip.contains('v0a') ||
	                zip.contains('v0b') ||
	                zip.contains('v0e') ||
	                zip.contains('v0g') ||
	                zip.contains('v0h') ||
	                zip.contains('v1a') ||
	                zip.contains('v1b') ||
	                zip.contains('v1c') ||
	                zip.contains('v1e') ||
	                zip.contains('v1h') ||
	                zip.contains('v1l') ||
	                zip.contains('v1n') ||
	                zip.contains('v1p') ||
	                zip.contains('v1r') ||
	                zip.contains('v1s') ||
	                zip.contains('v1t') ||
	                zip.contains('v1v') ||
	                zip.contains('v1w') ||
	                zip.contains('v1x') ||
	                zip.contains('v1y') ||
	                zip.contains('v1z') ||
	                zip.contains('v2a') ||
	                zip.contains('v2b') ||
	                zip.contains('v2c') ||
	                zip.contains('v2e') ||
	                zip.contains('v2h') ||
	                zip.contains('v4t') ||
	                zip.contains('v4v') 
	                )
                )
            {
				return true;
			} else
				return false;
		}
		return false;
	}

	public static boolean BC2( string zip)
	{
		if (zip.startswith('v'))
		{
			if ( zip.contains('v0a1l0') ||
				zip.contains('v0a1h0') ||
				zip.contains('v0a1k0') ||
				zip.contains('v0a1l0') ||
				zip.contains('v0a0a5') ||
				zip.contains('v0a1m0') ||
				zip.contains('v1a150') ||
				zip.contains('v1c')    ||
				zip.contains('v0b1v1') ||
				zip.contains('v0b2g0') ||
				zip.contains('v0b1m0') ||
				zip.contains('v0b1h0') 
			) {
				return true;
			}
		}
		return false;
	}

	
    public static string GetUser(string country2,string zip2)
    
    {
    	System.Debug ('get user zip2 = ' + zip2 + ' country='+country2);
    	if (zip2==null || country2==null)
    		return '005A0000000MOJpIAO';
        string zip = zip2.toLowerCase();

		string subZip =zip;
		if( zip.length() > 5 )
			subzip = zip.substring(0, 5);

    	    
        string country = country2.toLowerCase();
        if (country=='mexico' || country=='mex' || country == 'mx')
        {
        	if (zip2 >= '21000' && zip <'24000')
        		return '005A0000001BElBIAW'; //matt galloro
        	else
        		return '005A0000000N7pUIAS';
        } else if( GetUserFromAddress.IsCaribbeanCountry(country))
        {
        	return GLobalstrings.CaribbeanUserID();
        } else if (country=='canada' || country=='can' || country=='ca' )
        {
        	zip = zip.replace('-','').replace(' ','');

            if (zip.startsWith('v'))
             {
				zip = zip.replace('-','').replace(' ','');
				if( BC2(zip))
					return '005A0000000N1loIAC';
				else  return '005A0000000O65SIAS';

            } else if (zip.startsWith('x') || zip.startsWith('t') || zip.startsWith('r') || zip.startsWith('s'))
            {
                return '005A0000000N1loIAC';
            }
            else if (zip.startsWith('j') || zip.startsWith('g') || zip.startsWith('h') || zip.startsWith('e') || zip.startsWith('a') || zip.startsWith('b') || zip.startsWith('c'))
            {
                return '005A0000000N1jsIAC';
            }
            else if ( zip.startsWith('l') || zip.startsWith('p') || zip.startsWith('n') || zip.startsWith('m') || zip.startsWith('k'))
            {
                return '005A0000000N7poIAC';
            }          
            return '005A0000000MOJpIAO';
        }
        else if (country != 'united states' && country !='usa' && country != 'us')
        	return '005A0000000MOJpIAO';
        else if (zip=='1')
            return '005A0000000M8piIAC';
else if (subzip>='00601' && subzip <='00988') 
{
    return '005A0000000MOi7IAG';
}
else if (subzip>='01000' && subzip <='02799') 
{
    return '005A0000001CtMlIAK';
}
else if (subzip>='02800' && subzip <='02999') 
{
    return '005A0000001CtMlIAK';
}
else if (subzip>='03000' && subzip <='03899') 
{
    return '005A0000001CtMlIAK';
}
else if (subzip>='03900' && subzip <='04999') 
{
    return '005A0000001CtMlIAK';
}
else if (subzip>='05000' && subzip <='05999') 
{
    return '005A0000001CtMlIAK';
}
else if (subzip>='06000' && subzip <='06999') 
{
    return '005A0000001CtMlIAK';
}
else if (subzip>='07000' && subzip <='07699') 
{
    return '005A0000000MOhbIAG';
}
else if (subzip>='07700' && subzip <='07799') 
{
    return '005A0000000MOhbIAG';
}
else if (subzip>='07800' && subzip <='07999') 
{
    return '005A0000000MOhbIAG';
}
else if (subzip>='08000' && subzip <='08799') 
{
    return '005A0000000N1jOIAS';
}
else if (subzip>='08800' && subzip <='08999') 
{
    return '005A0000000MOhbIAG';
}
else if (subzip>='10000' && subzip <='11999') 
{
    return '005A0000000MOhbIAG';
}
else if (subzip>='12000' && subzip <='12399') 
{
    return '005A0000000MOhbIAG';
}
else if (subzip>='12400' && subzip <='12799') 
{
    return '005A0000000MOhbIAG';
}
else if (subzip>='12800' && subzip <='14999') 
{
    return '005A0000000MOhbIAG';
}
else if (subzip>='15000' && subzip <='16899') 
{
    return '005A0000000N1mmIAC';
}
else if (subzip>='16900' && subzip <='17199') 
{
    return '005A0000000N1jOIAS';
} 
else if (subzip>='17200' && subzip <='17299') 
{
    return '005A0000000N1mmIAC';
}
else if (subzip>='17300' && subzip <='19699') 
{
    return '005A0000000N1jOIAS';
}
else if (subzip>='19700' && subzip <='19999') 
{
    return '005A0000000N1klIAC';
}
else if (subzip>='20000' && subzip <='21999') 
{
    return '005A0000000N1klIAC';
}
else if (subzip>='22000' && subzip <='24699') 
{
    return '005A0000000N1klIAC';
}
else if (subzip>='24700' && subzip <='26899') 
{
    return '005A0000000N1klIAC';
}
else if (subzip>='27000' && subzip <='28999') 
{
    return '005A0000000N1j5IAC';
}
else if (subzip>='29000' && subzip <='29999') 
{
    return '005A0000000N1j5IAC';
}
else if (subzip>='30000' && subzip <='31999') 
{
    return '005A0000000N1mcIAC';
}
else if (subzip>='32000' && subzip <='32299') 
{
    return '005A0000000MOi7IAG';//walker
}
else if (subzip>='32300' && subzip <='32399') 
{
    return '005A0000000N1i8IAC';//wingate
}
else if (subzip>='32400' && subzip <='32599') 
{
    return '005A0000000N1lPIAS';
}
else if (subzip>='32600' && subzip <='32699') 
{
    return '005A0000000N1i8IAC';
}
else if (subzip>='32700' && subzip <='32959') 
{
    return '005A0000000MOi7IAG'; //ron walker
}
else if (subzip>='32960' && subzip <='32971') 
{
    return '005A0000000N1j6IAC';
}
else if (subzip>='32972' && subzip <='32999') 
{
    return '005A0000000MOi7IAG';
}
else if (subzip>='33000' && subzip <='33499') 
{
    return '005A0000000N1j6IAC';
}
else if (subzip>='33500' && subzip <='33899') 
{
    return '005A0000000N1i8IAC';
}
else if (subzip>='33900' && subzip <='33999') 
{
    return '005A0000000N1j6IAC';
}
else if (subzip>='34000' && subzip <='34100') 
{
    return '005A0000000MOItIAO';
}
else if (subzip>='34100' && subzip <='34199') 
{
    return '005A0000000N1j6IAC';
}
else if (subzip>='34200' && subzip <='34299') 
{
    return '005A0000000N1i8IAC'; //robert wingate
}
else if (subzip>='34300' && subzip <='34399') 
{
    return '005A0000000MOItIAO';
}
else if (subzip>='34400' && subzip <='34499') 
{
    return '005A0000000N1i8IAC';
}
else if (subzip>='34600' && subzip <='34699') 
{
    return '005A0000000N1i8IAC';
}
else if (subzip>='34700' && subzip <='34799') 
{
    return '005A0000000MOi7IAG';
}
else if (subzip>='34900' && subzip <='34999') 
{
    return '005A0000000N1j6IAC';
}
else if (subzip>='35000' && subzip <='36499') 
{
    return '005A0000000N1lPIAS';
}
else if (subzip>='36500' && subzip <='36699') 
{
    return '005A0000001BlaN';
}
else if (subzip>='36700' && subzip <='36999') 
{
    return '005A0000000N1lPIAS';
}
else if (subzip>='37000' && subzip <='37299') 
{
    return '005A0000000N2nHIAS';
}
else if (subzip>='37300' && subzip <='37499') 
{
    return '005A0000000N1lPIAS';
}
else if (subzip>='37500' && subzip <='37599') 
{
    return '005A0000000N2nHIAS';
}
else if (subzip>='37600' && subzip <='37999') 
{
    return '005A0000000N1lPIAS';
}
else if (subzip>='38000' && subzip <='38599') 
{
    return '005A0000000N2nHIAS';
}
else if (subzip>='38600' && subzip <='38999') 
{
    return '005A0000000N2nHIAS';
}
else if (subzip>='39000' && subzip <='39699') 
{
    return '005A0000001BlaN';
}
else if (subzip>='39700' && subzip <='39799') 
{
    return '005A0000000N2nHIAS';
}
else if (subzip >='39801' && subzip <='39999')
{
	return '005A0000000N1mcIAC';
}
else if (subzip>='40000' && subzip <='42799') 
{
    return '005A0000000N1o4IAC';
}
else if (subzip>='43000' && subzip <='43299') 
{
    return '005A0000000N1o4IAC';
}
else if (subzip>='43300' && subzip <='43699') 
{
    return '005A0000000N1o4IAC';
}
else if (subzip>='43700' && subzip <='43999') 
{
    return '005A0000000N1o4IAC';
}
else if (subzip>='44000' && subzip <='44599') 
{
    return '005A0000000N1o4IAC';
}
else if (subzip>='44600' && subzip <='44799') 
{
    return '005A0000000N1o4IAC';
}
else if (subzip>='44800' && subzip <='44999') 
{
    return '005A0000000N1o4IAC';
}
else if (subzip>='45000' && subzip <='45799') 
{
    return '005A0000000N1o4IAC';
}
else if (subzip>='45800' && subzip <='45899') 
{
    return '005A0000000N1o4IAC';
}
else if (subzip>='46000' && subzip <='47999') 
{
    return '005A0000000N1o4IAC';  //paul nalette
}
else if (subzip>='48000' && subzip <='48999') 
{
    return '005A0000000N1jLIAS';
}
else if (subzip>='49000' && subzip <='49199') 
{
    return '005A0000000N1jLIAS';
}
else if (subzip>='49200' && subzip <='49299') 
{
    return '005A0000000N1jLIAS';
}
else if (subzip>='49300' && subzip <='49599') 
{
    return '005A0000000N1jLIAS';
}
else if (subzip>='49600' && subzip <='49999') 
{
    return '005A0000000N1jLIAS';
}


else if (subzip>='50000' && subzip <='52999') 
{
    return '005A0000001BWr4IAG';
}
else if (subzip>='53000' && subzip <='53999') 
{
    return '005A0000000N1kvIAC';
}
else if (subzip>='54000' && subzip <='54099') 
{
    return '005A0000000PaleIAC';
}
else if (subzip>='54100' && subzip <='54599') 
{
    return '005A0000000N1kvIAC';
}
else if (subzip>='54600' && subzip <='54899') 
{
    return '005A0000000PaleIAC';
}
else if (subzip>='54900' && subzip <='54999') 
{
    return '005A0000000N1kvIAC';
}
else if (subzip>='55000' && subzip <='56999') 
{
    return '005A0000000PaleIAC';
}
else if (subzip>='57000' && subzip <='57999') 
{
    return '005A0000000PaleIAC';
}
else if (subzip>='58000' && subzip <='58999') 
{
    return '005A0000000PaleIAC';
}
else if (subzip>='59000' && subzip <='59399') 
{
    return '005A0000000MOJqIAO';
}
else if (subzip>='59400' && subzip <='59499') 
{
    return '005A0000000MOfjIAG';
}
else if (subzip>='59500' && subzip <='59599') 
{
    return '005A0000000MOJqIAO';
}
else if (subzip>='59600' && subzip <='59999') 
{
    return '005A0000000MOfjIAG';
}
else if (subzip>='60000' && subzip <='61999') 
{
    return '005A0000000N1kvIAC';
}
else if (subzip>='62000' && subzip <='62999') 
{
    return '005A0000000N1mIIAS';
}
else if (subzip>='63000' && subzip <='65999') 
{
    return '005A0000000N1mIIAS';
}
else if (subzip>='66000' && subzip <='67999')  
{
    return '005A0000000N1mIIAS';
}

else if (subzip>='68000' && subzip <='69999') 
{
    return '005A0000001BWr4IAG';
}

else if (subzip>='70000' && subzip <='71599') 
{
    return '005A0000001BlaN';
}
else if (subzip>='71600' && subzip <='72999') 
{
    return '005A0000000N2nHIAS';
}
else if (subzip>='73000' && subzip <='74999') 
{
    return '005A0000000N1kHIAS';
}
else if (subzip>='75000' && subzip <='76899') 
{
    return '005A0000000N1kHIAS';
}           
//else if (subzip >='76500' && subzip <='76599')
//{
//	return '005A0000000O0zyIAC';
//}
//else if (subzip>='76600' && subzip <='76799') 
//{
//    return '005A0000000N1kHIAS';
//}  
else if (subzip >='76900' && subzip <='76999')
{
	return '005A0000000O0zyIAC';
}
else if (subzip>='77000' && subzip <='77999') 
{
    return '005A0000000MOi1IAG';
}
else if (subzip >='78000' && subzip <='78299')
{
	return '005A0000000O0zyIAC';
}
else if (subzip>='78300' && subzip <='78599') 
{
    return '005A0000000MOi1IAG';
}
else if (subzip >='78600' && subzip <='78999')
{
	return '005A0000000O0zyIAC';
}

else if (subzip>='79000' && subzip <='79699') 
{
    return '005A0000000N1kHIAS';
}
else if (subzip >='79700' && subzip <='79999')
{
	return '005A0000000O0zyIAC';
}
else if (subzip>='80000' && subzip <='83199') 
{
    return '005A0000000MOJqIAO';
}
else if (subzip>='83200' && subzip <='83899') 
{
    return '005A0000000MOfjIAG';
}
else if (subzip>='83200' && subzip <='83999') 
{
    return '005A0000000MOfjIAG';
}
else if (subzip>='84000' && subzip <='84799') 
{
    return '005A0000000N1nuIAC';
}
else if (subzip>='85000' && subzip <='86599') 
{
//    return '005A0000001AyJMIA0'; //tracy carpenter az
    return '005A0000000N1mY'; //tracy carpenter az
}
else if (subzip=='88901' || subzip =='88905') 
{
	//these two are kinda odd, it seems there may
	// not even be any other zip codes in 88000 range
//    return '005A0000001AyJMIA0'; 
    return '005A0000007NiqS';  
}
else if (subzip>='87000' && subzip <='88999') 
{
    return '005A0000000MOJqIAO';
}
else if (subzip>='89000' && subzip <='89199') 
{

    return '005A0000007NiqS'; 
}
else if (subzip>='89300' && subzip <='89899') 
{
    return '005A0000000N1l5IAC';
}
else if (subzip>='90000' && subzip <='93599') 
{
    return '005A0000001BElBIAW';
}
else if (subzip>='93600' && subzip <='96199') 
{
    return '005A0000000N1l5IAC';
}
else if (subzip>='96700' && subzip <='99999') 
{
    return '005A0000000MOfjIAG';
}

 else if( zip == 'TEST') 
  return GlobalStrings.CatchallUserIDForAssignment(); //need for unit tests

        else
       //     return GlobalStrings.CatchallUserIDForAssignment(); //this is for sandbox testing
        return '005A0000000MOJpIAO'; //this is for production releasing     
    }

    
}