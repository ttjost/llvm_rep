#include <stdint.h>

uint8_t *aa = (uint8_t*) "asdffeagewaHAFEFaeDsFEawFdsFaefaeerdjgpim23";

uint16_t icrc1(uint16_t crc, uint8_t onech)
{
  int32_t i;
  uint16_t ans = (crc ^ onech << 8);
  for (i = 0; i < 8; i++)
    {
      if (ans & 0x8000) {
        ans = (ans << 1) ^ 4129;
      } else {
        ans <<= 1;
      }
    }
  return ans;
}

uint16_t icrc(uint16_t crc, uint8_t *lin, uint32_t len, int16_t jinit, int32_t jrev)
{
  static uint16_t icrctb[256], init = 0;
  static uint8_t rchr[256];
  uint16_t tmp1, tmp2, j, cword = crc;
  static uint8_t it[16] = {0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15};
  
  if (!init)
  {
      init = 1;
      for (j = 0; j <= 255; j++)
      {
          icrctb[j] = icrc1(j << 8, (uint8_t) 0);
          rchr[j] = (uint8_t) (it[j & 0xF] << 4 | it[j >> 4]);
      }
  }
  
  if (jinit >= 0)
  {
    cword = ((uint8_t) jinit) | (((uint8_t) jinit) << 8);
  }
  else 
	  {
	  	if (jrev < 0)
	  	{
	  		cword = rchr[((uint8_t) ((cword) >> 8))] | rchr[((uint8_t) ((cword) & 0xFF))] << 8;
	  	}
	  }
    
  
  for (j = 1; j <= len; j++)
  {
      if (jrev < 0)
      {
          tmp1 = rchr[lin[j]] ^ ((uint8_t) ((cword) >> 8));
      } 
      else
      {
          tmp1 = lin[j] ^ ((uint8_t) ((cword) >> 8));
      }
      cword = icrctb[tmp1] ^ ((uint8_t) ((cword) & 0xFF)) << 8;
  }
  
  if (jrev >= 0)
  {
      tmp2 = cword;
  } 
  else
  {
      tmp2 = rchr[((uint8_t) ((cword) >> 8))] | rchr[((uint8_t) ((cword) & 0xFF))] << 8;
  }
  
  return (tmp2);
}

int main(int argc, char *argv[])
{
  uint16_t i1, i2;
  int32_t n;

  i1 = icrc(0, aa, 40, (int16_t) 0, 1);
  i2 = icrc(i1, aa, 42, (int16_t) -1, 1);
  

  if (i2 != 268)
  {
    return 0x0F;
  } 
  else
  {
    return 0x42;
  }
  
  return 0;
}
