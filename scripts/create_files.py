import os

if __name__ == "__main__":
    # Create the 'data' directory if it doesn't exist
    os.makedirs("data", exist_ok=True)
    
    for i in range(1, 6):
        filename = f"file_{i}.txt"
        filepath = os.path.join("data", filename)
        
        with open(filepath, "w") as f:
            f.write(f"This is the content of {filename}\n")

    