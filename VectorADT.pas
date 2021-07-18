UNIT VectorADT;

INTERFACE  

TYPE
    Vector = Pointer;

PROCEDURE Add(VAR s: Vector; val: INTEGER); //AppendValue

PROCEDURE SetElementAt(VAR s: Vector; pos: INTEGER; val: INTEGER);

PROCEDURE GetElementAt(VAR s: Vector; pos: INTEGER; VAR val: INTEGER);

PROCEDURE RemoveElementAt(VAR s: Vector; pos: INTEGER);

FUNCTION Size(s: Vector): INTEGER; //Size of container

FUNCTION Capacity(s: Vector): INTEGER;

PROCEDURE DisplayArray(s: Vector);


IMPLEMENTATION

TYPE
    State = ^StateRec;
    IntArray = ARRAY [1..1] OF INTEGER;
    StateRec = RECORD
        IntArrayPtr: ^IntArray;
        arrayLength: INTEGER;
        arrayCount: INTEGER;
    END;
        
VAR
    i: INTEGER;


PROCEDURE InitArray(VAR s: Vector; arrayLength: INTEGER);
    VAR
        st: State;
    BEGIN
        New(st);
        s := st;

        GetMem(s, arrayLength * SizeOf(INTEGER));
        FOR i := 1 TO arrayLength DO BEGIN
            (*$R-*)
            st^.IntArrayPtr^[i] := 0;
            (*$R+*)
        END;
        st^.arrayLength := arrayLength;
        st^.arrayCount := 0;
        s := st;
    END;

PROCEDURE InitArray2(VAR s: Vector);
    VAR
        st: State;
    BEGIN
        st := State(s);
        GetMem(s, st^.arrayLength * SizeOf(INTEGER));
        FOR i := 1 TO st^.arrayLength DO BEGIN
        (*$R-*)
            st^.IntArrayPtr^[i] := 0;
            (*$R+*)
        END;
    END;


PROCEDURE Add(VAR s: Vector; val: INTEGER);
    VAR
        newAP: State;
    BEGIN
        IF s = NIL THEN BEGIN
            InitArray(State(s), 5);
        END;
        IF State(s)^.arrayCount < State(s)^.arrayLength THEN BEGIN
            State(s)^.arrayCount := State(s)^.arrayCount + 1;
            (*$R-*)
            State(s)^.IntArrayPtr^[State(s)^.arrayCount] := val;
            (*$R+*)
        END ELSE BEGIN
            New(newAP);
            GetMem(newAP, (State(s)^.arrayLength * 2) * SizeOf(INTEGER));
            State(newAP)^.arrayLength := State(s)^.arrayLength * 2;
            State(newAP)^.arrayCount := State(s)^.arrayCount;
            FOR i := 1 TO (State(newAP)^.arrayLength DIV 2) DO BEGIN
                (*$R-*)
                State(newAP)^.IntArrayPtr^[i] := State(s)^.IntArrayPtr^[i];
                (*$R+*)
            END;
            FOR i := (State(newAP)^.arrayLength DIV 2 + 1) TO State(newAP)^.arrayLength DO BEGIN
                (*$R-*)
                State(newAP)^.IntArrayPtr^[i] := 0;
                (*$R+*)
            END;
            
            Dispose(State(s));
            State(s) := State(newAP);

            IF State(s)^.arrayCount < State(s)^.arrayLength THEN BEGIN
                State(s)^.arrayCount := State(s)^.arrayCount + 1;
                (*$R-*)
                State(s)^.IntArrayPtr^[State(s)^.arrayCount] := val;
                (*$R+*)
            END;            
        END;
    END;

PROCEDURE SetElementAt(VAR s: Vector; pos: INTEGER; val: INTEGER);
    VAR
        newAP: State;
    BEGIN
        IF (pos <= State(s)^.arrayLength) AND (pos > 0) THEN BEGIN
            (*$R-*)
            State(s)^.IntArrayPtr^[pos] := val;
            (*$R+*)
        END ELSE IF (pos > State(s)^.arrayLength) AND (pos > 0) THEN BEGIN
            New(newAP);
            GetMem(newAP, (State(s)^.arrayLength * 2) * SizeOf(INTEGER));
            State(newAP)^.arrayLength := State(s)^.arrayLength * 2;
            State(newAP)^.arrayCount := State(s)^.arrayCount;
            FOR i := 1 TO (State(s)^.arrayLength DIV 2) DO BEGIN
                (*$R-*)
                newAP^.IntArrayPtr^[i] := State(s)^.IntArrayPtr^[i];
                (*$R+*)
            END;
            FOR i := (State(s)^.arrayLength DIV 2 + 1) TO State(s)^.arrayLength DO BEGIN
                (*$R-*)
                newAP^.IntArrayPtr^[i] := 0;
                (*$R+*)
            END;
            
            Dispose(State(s));
            State(s) := newAP;
            
            IF (pos <= State(s)^.arrayLength) AND (pos > 0) THEN BEGIN
                (*$R-*)
                State(s)^.IntArrayPtr^[pos] := val;
                (*$R+*)
            END;
        END;
    END;

PROCEDURE GetElementAt(VAR s: Vector; pos: INTEGER; VAR val: INTEGER);
    BEGIN
        IF (pos <= State(s)^.arrayLength) AND (pos > 0) THEN BEGIN
            (*$R-*)
            val := State(s)^.IntArrayPtr^[pos];
            (*$R+*)
        END ELSE
            val := 0;
    END;

PROCEDURE RemoveElementAt(VAR s: Vector; pos: INTEGER);
    BEGIN  
        IF (pos <= State(s)^.arrayLength) AND (pos > 0) THEN BEGIN
            FOR i := pos TO (State(s)^.arrayLength - 1) DO BEGIN
                (*$R-*)
                State(s)^.IntArrayPtr^[i] := State(s)^.IntArrayPtr^[i + 1];
                (*$R+*)
            END;
            (*$R-*)
            State(s)^.IntArrayPtr^[State(s)^.arrayLength] := 0;
            (*$R+*)
            State(s)^.arrayCount := State(s)^.arrayCount - 1;
        END;
    END;

FUNCTION Size(s: Vector): INTEGER;
    BEGIN
        Size := State(s)^.arrayCount;
    END;

FUNCTION Capacity(s: Vector): INTEGER;
    BEGIN
        Capacity := State(s)^.arrayLength;
    END;

PROCEDURE DisplayArray(s: Vector);
    BEGIN
        FOR i := 1 TO State(s)^.arrayLength DO BEGIN
        (*$R-*)
            Write(State(s)^.IntArrayPtr^[i], ', ');
            (*$R+*)
        END;
        WriteLn;
    END;

BEGIN

END.

