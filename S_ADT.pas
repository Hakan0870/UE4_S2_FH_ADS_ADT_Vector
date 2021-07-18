UNIT S_ADT;


INTERFACE  (* "extern" *)

TYPE
    Stack = Pointer; 

PROCEDURE Init(VAR s: Stack);

PROCEDURE Push(VAR s: Stack; (*IN*)value: INTEGER);

PROCEDURE Pop(VAR s: Stack; (*OUT*) VAR value: INTEGER);

FUNCTION IsEmpty(s: Stack): BOOLEAN; 

PROCEDURE Done(VAR s: Stack);


IMPLEMENTATION  

    USES
        VectorADT;

    TYPE
        StatePtr = ^StateRec;
        State = RECORD
            data: Stack;
        END;


    PROCEDURE Init(VAR s: Stack);
        VAR
            st: State;
        BEGIN
            New(st);
            s := st;
            InitArray(StatePtr(state)^.data);
        END;


    PROCEDURE Push(VAR s: Stack;(*IN*)value: INTEGER;
        BEGIN
            Add(StatePtr(state)^.data, value);
        END;

    PROCEDURE Pop(VAR s: Stack; (*OUT*) VAR value: INTEGER);
        BEGIN
            GetElementAt(StatePtr(state)^.data, Size(StatePtr(state)^.data), value)
        END;

    FUNCTION IsEmpty(s: Stack): BOOLEAN;
        BEGIN
            IsEmpty := (State(s)^.data = NIL);
        END;


    PROCEDURE Done(VAR s: Stack);
        VAR
            n: Node;
            st: State;
        BEGIN
            st := State(s);
            WHILE st^.data <> NIL DO BEGIN
                n := st^.data^.next;
                Dispose(st^.data);
                st^.data := n;
            END;
            st^.data := NIL;
        END;


BEGIN

END.