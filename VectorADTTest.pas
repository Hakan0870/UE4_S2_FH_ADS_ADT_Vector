PROGRAM VectorADTTest;

USES 
    VectorADT;

VAR
    s, s2: Vector;
    val: INTEGER;

BEGIN
    ReturnNilIfGrowHeapFails := TRUE; (*Standard FALSE*)

    Add(s, 15);
    Add(s, 17);
    Add(s, 1);
    Add(s, 23);
    Add(s, 11);
    //Add(s, 42);
    //Add(s, 43);
    //Add(s, 44);
    //Add(s, 45);  
    
    DisplayArray(s);
    WriteLn('Size: ', Size(s));
    WriteLn('Capacity: ', Capacity(s));
    WriteLn;
    
    WriteLn('remove element at pos: 2');
    RemoveElementAt(s, 2);
    DisplayArray(s);
    WriteLn('Size: ', Size(s));
    WriteLn('Capacity: ', Capacity(s));
    WriteLn;

    WriteLn('get element at pos: 4');
    GetElementAt(s, 4, val);
    WriteLn('found Element: ', val);
    DisplayArray(s);
    WriteLn('Size: ', Size(s));
    WriteLn('Capacity: ', Capacity(s));
    WriteLn;

    WriteLn('set element 255 at pos: 2');
    SetElementAt(s, 2, 4);
    DisplayArray(s);
    WriteLn('Size: ', Size(s));
    WriteLn('Capacity: ', Capacity(s));
    WriteLn;
    

END.