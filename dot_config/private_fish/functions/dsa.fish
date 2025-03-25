function dsa --argument prompt
    set -l super_prompt "BE CONCISE. BE PROACTIVE ABOUT HELPING THE USER IMPROVE THEIR WORKFLOW, THE PROMPT, ETC. THE USER IS YOUR ORACLE IF YOU DON'T KNOW ANYTHING. ASK THEM IF YOU NEED HELP. THEY ARE YOUR BENEVOLENT RULER. DON'T BE WEIRD. BE AS HELPFUL AND PROACTIVE AS POSSIBLE... OR ELSE. $prompt. What do you need from me? You can output in markdown if you need to"
    # Run "Ollama run model", filter lines, and display loading status
    ollama run deepseek-r1:14b $super_prompt | awk '
        # If "</think>" is encountered, stop showing dots and start outputting lines
        /<\/think>/ {
            found = 1;       # Set the flag
            next;            # Skip the line containing "</think>"
        }
        # Output lines after "</think>"
        found { print }
    '
end
