# 2018-08-27 -- Til Thomas

BEGIN {
    print "#NEXUS\n\nBegin trees;"
    tree1=""
    j=0
}
/[[:digit:]]+;|\[/ {
    j++ 
    if (j==3) {
        print tree1
    }
    if (j%2) {
        gsub(/;/, "")
        treenum=strtonum($1)
        line="tree STATE_"treenum" [&lnP="$4",posterior="$2"] = [&R]" 
        if (j==1){
            tree1=line
            line="tree STATE_0 [&lnP="$4",posterior="$2"] = [&R]"
        }
        printf line
    } else {
        line=gensub(":([[:digit:].E-]+):([[:digit:].E-]+)",
                    "[\\&popsize=\\2]:\\1", "g")
        print line
        if (j==2) {
            tree1=tree1""line
        }
    } 
}
END {
    print "End;"
}
