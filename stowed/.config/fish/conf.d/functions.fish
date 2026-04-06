if status is-interactive
    function coln
        while read -l input
            echo $input | awk '{print $'$argv[1]'}'
        end
    end

    function rown --argument index
        sed -n "$index p"
    end

    function backup --argument filename
        cp $filename $filename.bak
    end

    function skip --argument n
        tail +(math 1 + $n)
    end

    function take --argument number
        head -$number
    end

    function gcm
        git commit -m "$argv"
    end
end
