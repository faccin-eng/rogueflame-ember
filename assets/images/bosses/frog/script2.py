from PIL import Image
import sys

def find_frames(img):
    """Encontra os frames baseado em colunas não-transparentes"""
    width, height = img.size
    pixels = img.load()
    
    frames = []
    in_frame = False
    frame_start = 0
    
    for x in range(width):
        has_content = False
        for y in range(height):
            if pixels[x, y][3] > 0:
                has_content = True
                break
        
        if has_content and not in_frame:
            frame_start = x
            in_frame = True
        elif not has_content and in_frame:
            frames.append((frame_start, x - 1))
            in_frame = False
    
    if in_frame:
        frames.append((frame_start, width - 1))
    
    return frames

def process_spritesheet(input_path, output_path, align="center"):
    img = Image.open(input_path).convert("RGBA")
    height = img.size[1]
    
    frames = find_frames(img)
    print(f"Encontrados {len(frames)} frames:")
    
    widths = []
    for i, (start, end) in enumerate(frames):
        w = end - start + 1
        widths.append(w)
        print(f"  Frame {i+1}: largura {w}px (colunas {start}-{end})")
    
    max_width = max(widths)
    print(f"\nMaior largura: {max_width}px")
    print(f"Alinhamento: {align}")
    
    new_img = Image.new("RGBA", (max_width * len(frames), height), (0, 0, 0, 0))
    
    for i, (start, end) in enumerate(frames):
        frame = img.crop((start, 0, end + 1, height))
        frame_width = end - start + 1
        
        if align == "left":
            offset_x = 0
        elif align == "right":
            offset_x = max_width - frame_width
        else:  # center
            offset_x = (max_width - frame_width) // 2
        
        new_img.paste(frame, (i * max_width + offset_x, 0))
    
    new_img.save(output_path)
    print(f"\nSalvo em: {output_path}")
    print(f"Dimensões: {new_img.size[0]}x{new_img.size[1]}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Uso: python script.py <imagem.png> [saida.png] [left|center|right]")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else "spritesheet_trimmed.png"
    align = sys.argv[3] if len(sys.argv) > 3 else "center"
    
    process_spritesheet(input_file, output_file, align)