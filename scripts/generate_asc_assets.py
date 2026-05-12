from pathlib import Path
from PIL import Image, ImageDraw, ImageFont, ImageFilter
import math

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "MarketingAssets" / "Screenshots"
ICON = ROOT / "MarketingAssets" / "Icons" / "app-icon-1024.png"

SIZES = {
    "iphone69": (1320, 2868),
    "iphone65": (1284, 2778),
    "iphone55": (1242, 2208),
    "ipad129": (2048, 2732),
}

SCENES = [
    {
        "slug": "home",
        "title": "ありえない会話、作れます。",
        "subtitle": "テンプレかランダムで、1分ネタスクショ",
        "screen": "home",
    },
    {
        "slug": "template",
        "title": "ネタの型、最初から8種類。",
        "subtitle": "告白風、先生呼び出し風、深夜DM風も",
        "screen": "template",
    },
    {
        "slug": "editor",
        "title": "名前も時刻も、ぜんぶ編集。",
        "subtitle": "既読、未読、色、アイコンまで自由",
        "screen": "editor",
    },
    {
        "slug": "export",
        "title": "作ったら、すぐ保存・共有。",
        "subtitle": "透かし入りの架空チャット画像で安心",
        "screen": "export",
    },
]


def font(size, bold=False):
    candidates = [
        r"C:\Windows\Fonts\YuGothB.ttc" if bold else r"C:\Windows\Fonts\YuGothM.ttc",
        r"C:\Windows\Fonts\meiryo.ttc",
        r"C:\Windows\Fonts\msgothic.ttc",
    ]
    for path in candidates:
        if Path(path).exists():
            return ImageFont.truetype(path, size=size)
    return ImageFont.load_default()


def rounded(draw, box, radius, fill, outline=None, width=1):
    draw.rounded_rectangle(box, radius=radius, fill=fill, outline=outline, width=width)


def text_center(draw, xy, text, fnt, fill):
    box = draw.textbbox((0, 0), text, font=fnt)
    draw.text((xy[0] - (box[2] - box[0]) / 2, xy[1] - (box[3] - box[1]) / 2), text, font=fnt, fill=fill)


def glow_line(base, box, radius, color, width):
    layer = Image.new("RGBA", base.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(layer)
    d.rounded_rectangle(box, radius=radius, outline=color, width=width)
    blur = layer.filter(ImageFilter.GaussianBlur(width * 2))
    base.alpha_composite(blur)
    base.alpha_composite(layer)


def gradient(size):
    w, h = size
    small_w, small_h = 220, 360
    img = Image.new("RGBA", (small_w, small_h), (0, 0, 0, 255))
    px = img.load()
    for y in range(small_h):
        for x in range(small_w):
            nx = x / max(1, small_w - 1)
            ny = y / max(1, small_h - 1)
            wave = (math.sin(nx * 7.0 + ny * 4.0) + 1) / 2
            r = int(10 + 50 * (1 - ny) + 75 * wave)
            g = int(8 + 26 * nx + 18 * (1 - ny))
            b = int(18 + 72 * ny + 70 * nx)
            px[x, y] = (r, g, b, 255)
    return img.resize((w, h), Image.Resampling.BICUBIC)


def draw_status(draw, x, y, w, scale):
    small = font(int(13 * scale), True)
    draw.text((x + int(20 * scale), y), "21:09", font=small, fill=(255, 255, 255, 235))
    draw.text((x + w - int(108 * scale), y), "5G  WiFi", font=small, fill=(255, 255, 255, 225))
    draw.rounded_rectangle((x + w - int(38 * scale), y + int(1 * scale), x + w - int(12 * scale), y + int(13 * scale)), radius=int(3 * scale), outline=(255, 255, 255, 220), width=max(1, int(1 * scale)))
    draw.rounded_rectangle((x + w - int(36 * scale), y + int(3 * scale), x + w - int(19 * scale), y + int(11 * scale)), radius=int(2 * scale), fill=(180, 255, 35, 240))


def bubble(draw, box, text, mine, scale):
    fill = (255, 33, 155, 255) if mine else (35, 39, 52, 255)
    if text == "保存しました":
        fill = (6, 210, 255, 255)
    rounded(draw, box, int(18 * scale), fill)
    draw.multiline_text((box[0] + int(16 * scale), box[1] + int(12 * scale)), text, font=font(int(16 * scale), True), fill=(255, 255, 255, 250), spacing=int(4 * scale))


def draw_chat_screen(draw, base, box, scale, mode):
    x, y, w, h = box
    rounded(draw, box, int(36 * scale), (8, 8, 16, 255), outline=(74, 74, 94, 255), width=max(1, int(2 * scale)))
    glow_line(base, box, int(36 * scale), (255, 35, 165, 145), max(2, int(3 * scale)))
    draw_status(draw, x, y + int(18 * scale), w, scale)

    header_y = y + int(54 * scale)
    draw.rectangle((x + int(1 * scale), header_y, x + w - int(1 * scale), header_y + int(72 * scale)), fill=(0, 0, 0, 255))
    draw.ellipse((x + int(18 * scale), header_y + int(15 * scale), x + int(62 * scale), header_y + int(59 * scale)), fill=(42, 44, 58, 255))
    text_center(draw, (x + int(40 * scale), header_y + int(38 * scale)), "ST" if mode == "export" else "Q", font(int(15 * scale), True), (255, 255, 255, 255))
    draw.text((x + int(76 * scale), header_y + int(15 * scale)), "となりの席の人" if mode != "export" else "スクショ劇場", font=font(int(17 * scale), True), fill=(255, 255, 255, 245))
    draw.text((x + int(76 * scale), header_y + int(41 * scale)), "架空チャット / joke preview", font=font(int(10 * scale), True), fill=(255, 255, 255, 135))

    top = header_y + int(96 * scale)
    if mode == "home":
        bubble(draw, (x + int(52 * scale), top, x + int(264 * scale), top + int(55 * scale)), "今日ちょっと話せる？", False, scale)
        bubble(draw, (x + w - int(206 * scale), top + int(72 * scale), x + w - int(26 * scale), top + int(126 * scale)), "え、なに？", True, scale)
        bubble(draw, (x + int(52 * scale), top + int(146 * scale), x + int(294 * scale), top + int(218 * scale)), "ずっと言おうと思ってた\nことある", False, scale)
        bubble(draw, (x + w - int(260 * scale), top + int(240 * scale), x + w - int(26 * scale), top + int(296 * scale)), "急にドラマ始まった？", True, scale)
    elif mode == "template":
        cards = [("LOVE", "告白された風"), ("DM", "キラキラDM風"), ("CALL", "先生呼び出し風"), ("MID", "深夜DM風")]
        cy = top
        for i, (emoji, label) in enumerate(cards):
            cx = x + int(28 * scale) + (i % 2) * int(160 * scale)
            yy = cy + (i // 2) * int(122 * scale)
            rounded(draw, (cx, yy, cx + int(138 * scale), yy + int(100 * scale)), int(12 * scale), (38, 36, 55, 255), outline=(0, 225, 255, 255), width=max(1, int(1 * scale)))
            draw.text((cx + int(14 * scale), yy + int(16 * scale)), emoji, font=font(int(17 * scale), True), fill=(180, 255, 35, 255))
            draw.text((cx + int(14 * scale), yy + int(58 * scale)), label, font=font(int(12 * scale), True), fill=(255, 255, 255, 235))
        bubble(draw, (x + int(42 * scale), top + int(270 * scale), x + int(288 * scale), top + int(330 * scale)), "テンプレを選んだら\nすぐ編集へ", False, scale)
    elif mode == "editor":
        bubble(draw, (x + int(48 * scale), top, x + int(292 * scale), top + int(62 * scale)), "放課後、少し職員室へ", False, scale)
        bubble(draw, (x + w - int(276 * scale), top + int(82 * scale), x + w - int(26 * scale), top + int(144 * scale)), "心当たりが多すぎます", True, scale)
        panel = (x + int(22 * scale), top + int(190 * scale), x + w - int(22 * scale), top + int(352 * scale))
        rounded(draw, panel, int(16 * scale), (38, 36, 55, 255), outline=(255, 40, 165, 255), width=max(1, int(1 * scale)))
        draw.text((panel[0] + int(18 * scale), panel[1] + int(16 * scale)), "会話設定", font=font(int(15 * scale), True), fill=(255, 255, 255, 245))
        for n, label in enumerate(["名前", "時刻", "既読", "色"]):
            yy = panel[1] + int(52 * scale) + n * int(25 * scale)
            draw.text((panel[0] + int(18 * scale), yy), label, font=font(int(11 * scale), True), fill=(255, 255, 255, 180))
            draw.rounded_rectangle((panel[0] + int(80 * scale), yy - int(3 * scale), panel[2] - int(20 * scale), yy + int(16 * scale)), radius=int(5 * scale), fill=(74, 70, 95, 255))
    else:
        bubble(draw, (x + int(50 * scale), top, x + int(292 * scale), top + int(58 * scale)), "この会話、後世に残そう", False, scale)
        bubble(draw, (x + w - int(220 * scale), top + int(80 * scale), x + w - int(26 * scale), top + int(136 * scale)), "スクショ撮っていい？", True, scale)
        bubble(draw, (x + int(70 * scale), top + int(174 * scale), x + int(250 * scale), top + int(230 * scale)), "保存しました", False, scale)
        rounded(draw, (x + int(42 * scale), top + int(278 * scale), x + w - int(42 * scale), top + int(334 * scale)), int(14 * scale), (42, 42, 58, 255), outline=(180, 255, 35, 255), width=max(1, int(1 * scale)))
        text_center(draw, (x + w / 2, top + int(306 * scale)), "Made with スクショ劇場", font(int(14 * scale), True), (255, 255, 255, 165))

    text_center(draw, (x + w / 2, y + h - int(24 * scale)), "Made with スクショ劇場", font(int(10 * scale), True), (255, 255, 255, 120))


def draw_device(base, scene, size):
    w, h = size
    draw = ImageDraw.Draw(base)
    is_ipad = w >= 1800
    margin = int(w * (0.08 if is_ipad else 0.075))
    title_size = int(w * (0.046 if is_ipad else 0.053))
    sub_size = int(w * (0.023 if is_ipad else 0.030))
    title_y = int(h * (0.055 if is_ipad else 0.065))

    icon = Image.open(ICON).convert("RGBA").resize((int(w * 0.13), int(w * 0.13)))
    base.alpha_composite(icon, (w - margin - icon.width, title_y - int(w * 0.01)))
    text_w = w - margin * 3 - icon.width
    while title_size > 24 and draw.textbbox((margin, title_y), scene["title"], font=font(title_size, True))[2] > margin + text_w:
        title_size -= 2
    draw.text((margin, title_y), scene["title"], font=font(title_size, True), fill=(255, 255, 255, 255))
    draw.text((margin, title_y + int(title_size * 1.22)), scene["subtitle"], font=font(sub_size, True), fill=(210, 245, 255, 255))

    phone_w = int(w * (0.54 if is_ipad else 0.70))
    phone_h = int(phone_w * 2.05)
    if phone_h > int(h * 0.72):
        phone_h = int(h * 0.72)
        phone_w = int(phone_h / 2.05)
    phone_x = (w - phone_w) // 2
    phone_y = h - phone_h - int(h * (0.055 if is_ipad else 0.045))
    scale = phone_w / 390
    draw_chat_screen(draw, base, (phone_x, phone_y, phone_w, phone_h), scale, scene["screen"])

    pill_y = phone_y - int(62 * scale)
    rounded(draw, (phone_x + int(16 * scale), pill_y, phone_x + phone_w - int(16 * scale), pill_y + int(40 * scale)), int(20 * scale), (42, 42, 66, 255), outline=(118, 118, 150, 255), width=max(1, int(1 * scale)))
    text_center(draw, (phone_x + phone_w / 2, pill_y + int(20 * scale)), "架空チャット画像作成アプリ", font(int(14 * scale), True), (255, 255, 255, 220))


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    for prefix, size in SIZES.items():
        for idx, scene in enumerate(SCENES, start=1):
            img = gradient(size)
            overlay = Image.new("RGBA", size, (0, 0, 0, 0))
            d = ImageDraw.Draw(overlay)
            w, h = size
            for cx, cy, r, color in [
                (int(w * 0.16), int(h * 0.18), int(w * 0.22), (255, 35, 165, 52)),
                (int(w * 0.82), int(h * 0.34), int(w * 0.20), (0, 230, 255, 46)),
                (int(w * 0.38), int(h * 0.88), int(w * 0.24), (190, 255, 35, 36)),
            ]:
                d.ellipse((cx - r, cy - r, cx + r, cy + r), fill=color)
            img.alpha_composite(overlay.filter(ImageFilter.GaussianBlur(int(w * 0.035))))
            draw_device(img, scene, size)
            img.convert("RGB").save(OUT / f"{prefix}_{idx:02d}_{scene['slug']}.png", quality=95)


if __name__ == "__main__":
    main()
