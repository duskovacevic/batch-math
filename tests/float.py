def Set(value: str) -> str:
    if (value.find('.') ==-1):
        value = f"{value}.0"

    parts = value.split(".")
    whole = int(parts[0])
    sign = False
    if (parts[0][0] == "-"):
        sign = True
        whole = -whole

    if whole == 0:
        msb = 0
    else:
        msb = MostSignificantBit(whole)

    binFraction = 0
    fmsb = 0
    fe = 0
    e = 0
    if (len(parts) == 2):
        decFraction = int(parts[1])
        if (decFraction != 0):
            target = int("1" + "0" * len(parts[1]))
            test = decFraction
            while (test != target and fmsb < 31 - msb):
                test *= 2
                if (binFraction != 0):
                    binFraction <<= 1
                else:
                    fe += 1
                if (test >= target):
                    binFraction |= 1
                    test -= target
                if (binFraction != 0):
                    fmsb += 1

    if (whole != 0):
        m = whole << (31 - msb)
        if (binFraction > 0):
            f = binFraction >> fe - 1
            m |= f
        e = msb - 1
    else:
        m = binFraction << 31 - fmsb
        e = -fe
	
    if (sign == True):
        m = -m
            
    return f"{m}E{e}"

def MostSignificantBit(value: int) -> int:
    if (value == 0):
        return 0
    match = 0x40000000
    msb = 31
    while ((value & match) == 0):
        match >>= 1
        msb -= 1
    return msb

def ToString(value: str) -> str:
    if (value == "+Inf" or value == "-Inf" or value == "NaN"):
        return value

    sign = ""
    whole = 0
    ma, e = value.split("E", 1)

    ma = int(ma)
    e = int(e)
    
    if (ma < 0):
        sign = "-"
        ma = -ma

    binFraction = ma
    if (e >= -1):
        whole = ma >> (30 - e)
        binFraction = ma - (whole << (30 - e))
        binFraction <<= e + 1
    else:
        whole = 0
        binFraction >>= -(e + 1)
                
    test = 0x40000000
    
    bits = [500000000, 250000000, 125000000, 62500000, 31250000, 15625000, 7812500, 3906250, 1953125,
            976562, 488281, 244140, 122070, 61035, 30517, 15258, 7629, 
            3814, 1907, 953, 476, 238, 119, 59, 29, 
            14, 7, 3, 1, 0, 0]
    
    fbits = [0, 0, 0, 0, 0, 0, 0, 0, 
             500000000, 250000000, 625000000, 312500000, 156250000, 578125000, 789062500, 394531250, 
             697265625, 348632812, 674316406, 837158203, 418579101, 209289550, 604644775, 802322387, 
             901161193, 450580596, 725290298, 862645149, 931322574, 465661287]
    
    ffbits = [0, 0, 0, 0, 0, 0, 0, 0, 
              0, 0, 0, 0, 0, 0, 0, 0,
              500000000, 250000000, 125000000, 562500000, 781250000, 390625000, 695312000, 847656000, 
              923828000, 461914000, 230957000, 615478500, 307739260, 0]

    decFraction = 1000000000
    fdecFrac=0
    ffdecFrac=0

    for i in range(30):

        compare = binFraction & test
        
        bit=bits[i]
        fbit=fbits[i]
        ffbit=ffbits[i]
        
        if (compare > 0):
            ffdecFracCheck = ffdecFrac + ffbit

            if (ffdecFracCheck >= 2000000000 or ffdecFracCheck < 0):
                ffdecFrac -= 1000000000
                ffdecFrac += fbit
                fdecFrac += 1
            else:
                ffdecFrac += ffbit

            fdecFracCheck = fdecFrac + fbit
            
            if (fdecFracCheck >= 2000000000 or fdecFracCheck < 0):
                fdecFrac -= 1000000000
                fdecFrac += fbit
                decFraction += 1
            else:
                fdecFrac += fbit

            decFraction = decFraction + bit
        
        test >>= 1

    decFraction = str(decFraction)
    fdecFrac = str(fdecFrac)
    ffdecFrac = str(ffdecFrac)   
    return f"{sign}{whole}.{decFraction[1:]}{fdecFrac[1:]}{ffdecFrac[1:]}"