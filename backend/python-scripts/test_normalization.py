from ingestion import normalize_name, ARTIST_NORMALIZATION_MAP

# Mock database values
mock_known_names = {
    "Anup Rubens",
    "A. R. Rahman",
    "Devi Sri Prasad",
    "S. Thaman"
}

test_cases = [
    # Static Map Tests
    ("a.r.rahman", "A. R. Rahman", "Static Map"),
    
    # Exact Match (Case Insensitive -> Exact DB Case)
    ("ANUP RUBENS", "Anup Rubens", "Exact Match Case Correction"),
    
    # Fuzzy Match Tests
    ("nup Rubens", "Anup Rubens", "Fuzzy Match (Missing Start)"),
    ("Anup Rubense", "Anup Rubens", "Fuzzy Match (Extra End)"),
    ("Devi Sri Prasa", "Devi Sri Prasad", "Fuzzy Match (Typo)"),
    
    # No Match Tests
    ("Unknown Artist", "Unknown Artist", "No Match"),
    ("Some New Guy", "Some New Guy", "No Match")
]

print(f"Running Dynamic Normalization Tests with {len(mock_known_names)} known names...")
print("-" * 60)

passes = 0
for input_name, expected, description in test_cases:
    result = normalize_name(input_name, mock_known_names)
    status = "PASS" if result == expected else "FAIL"
    if status == "PASS":
        passes += 1
        
    print(f"[{status}] {description}")
    print(f"   Input:    '{input_name}'")
    print(f"   Output:   '{result}'")
    if status == "FAIL":
        print(f"   Expected: '{expected}'")
    print("-" * 60)

print(f"\nResult: {passes}/{len(test_cases)} passed.")
