UNIT VectorADS;

INTERFACE  

PROCEDURE Add(val: INTEGER); //AppendValue

PROCEDURE SetElementAt(pos: INTEGER; val: INTEGER);

PROCEDURE GetElementAt(pos: INTEGER; VAR val: INTEGER);

PROCEDURE RemoveElementAt(pos: INTEGER);

FUNCTION Size: INTEGER; //Size of container

FUNCTION Capacity: INTEGER;

PROCEDURE DisplayArray;



IMPLEMENTATION

TYPE
    IntArray= ARRAY [1..1] OF INTEGER;
    IntArrayPtr= ^IntArray;
VAR
    ap: IntArrayPtr;
    i: INTEGER;
    arrayLength: INTEGER;
    arrayCount: INTEGER;

PROCEDURE InitPointer(VAR ap: IntArrayPtr);
    BEGIN
        ap := NIL;
    END;

PROCEDURE InitArray(VAR ap: IntArrayPtr);
    BEGIN
        GetMem(ap, arrayLength * SizeOf(INTEGER));
        FOR i := 1 TO arrayLength DO BEGIN
            ap^[i] := 0;
        END;
    END;


PROCEDURE Add(val: INTEGER);
    VAR
        newAP: IntArrayPtr;
    BEGIN
        IF ap = NIL THEN BEGIN
            InitArray(ap);
        END;
        IF arrayCount < arrayLength THEN BEGIN
            arrayCount := arrayCount + 1;
            ap^[arrayCount] := val;
        END ELSE BEGIN
            InitPointer(newAP);
            arrayLength := arrayLength * 2;
            InitArray(newAP);
            FOR i := 1 TO (arrayLength DIV 2) DO BEGIN
                newAP^[i] := ap^[i];
            END;
            FOR i := (arrayLength DIV 2 + 1) TO arrayLength DO BEGIN
                newAP^[i] := 0;
            END;
            Dispose(ap);
            ap := newAP;

            IF arrayCount < arrayLength THEN BEGIN
                arrayCount := arrayCount + 1;
                ap^[arrayCount] := val;
            END;            
        END;
    END;

PROCEDURE SetElementAt(pos: INTEGER; val: INTEGER);
    VAR
        newAP: IntArrayPtr;
    BEGIN
        IF (pos <= arrayLength) AND (pos > 0) THEN BEGIN
            ap^[pos] := val;
        END ELSE IF (pos > arrayLength) AND (pos > 0) THEN BEGIN
            InitPointer(newAP);
            arrayLength := arrayLength * 2;
            InitArray(newAP);
            FOR i := 1 TO (arrayLength DIV 2) DO BEGIN
                newAP^[i] := ap^[i];
            END;
            FOR i := (arrayLength DIV 2 + 1) TO arrayLength DO BEGIN
                newAP^[i] := 0;
            END;
            Dispose(ap);
            ap := newAP;

            IF (pos <= arrayLength) AND (pos > 0) THEN BEGIN
                ap^[pos] := val;
            END;
        END;
    END;

PROCEDURE GetElementAt(pos: INTEGER; VAR val: INTEGER);
    BEGIN
        IF (pos <= arrayLength) AND (pos > 0) THEN BEGIN
            val := ap^[pos];
        END ELSE
            val := 0;
    END;

PROCEDURE RemoveElementAt(pos: INTEGER);
    BEGIN  
        IF (pos <= arrayLength) AND (pos > 0) THEN BEGIN
            FOR i := pos TO (arrayLength - 1) DO BEGIN
                ap^[i] := ap^[i + 1];
            END;
            ap^[arrayLength] := 0;
            arrayCount := arrayCount - 1;
        END;
    END;

FUNCTION Size: INTEGER;
    BEGIN
        Size := arrayCount;
    END;

FUNCTION Capacity: INTEGER;
    BEGIN
        Capacity := arrayLength;
    END;

PROCEDURE DisplayArray;
    BEGIN
        FOR i := 1 TO arrayLength DO BEGIN
            Write(ap^[i], ', ');
        END;
        WriteLn;
    END;


BEGIN
    InitPointer(ap);
    arrayLength := 5;
    arrayCount := 0;
END.

