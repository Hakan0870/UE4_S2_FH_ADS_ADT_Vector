PROGRAM VectorADSTest;


USES 
    VectorADS;


VAR

    val: INTEGER;

BEGIN
    ReturnNilIfGrowHeapFails := TRUE; (*Standard FALSE*)

    Add(15);
    Add(17);
    Add(1);
    Add(23);
    Add(115);
    //Add(44);
    DisplayArray;
    WriteLn('Size: ', Size);
    WriteLn('Capacity: ', Capacity);
    WriteLn;

    WriteLn('remove element at pos: 2');
    RemoveElementAt(2);
    DisplayArray;
    WriteLn('Size: ', Size);
    WriteLn('Capacity: ', Capacity);
    WriteLn;

    WriteLn('get element at pos: 4');
    GetElementAt(4, val);
    WriteLn('found Element: ', val);
    DisplayArray;
    WriteLn('Size: ', Size);
    WriteLn('Capacity: ', Capacity);
    WriteLn;

    WriteLn('set element 255 at pos: 2');
    SetElementAt(2, 255);
    DisplayArray;
    WriteLn('Size: ', Size);
    WriteLn('Capacity: ', Capacity);
    WriteLn;

END.