import requests
import shutil
from datetime import datetime, timedelta
from PIL import Image, ImageFont, ImageDraw

def downloader(url, file_dest):
    """
    Downloads the file to the given dest
    Args:
        url: 
    """
    r = requests.get(url, stream = True)
    if r.status_code == 200:
        # Set decode_content value to True, otherwise the downloaded image file's size will be zero.
        r.raw.decode_content = True

        # Open a local file with wb ( write binary ) permission.
        with open(file_dest,'wb') as f:
            shutil.copyfileobj(r.raw, f)

        print('Image sucessfully Downloaded: ',file_dest)
    else:
        print('Image Couldn\'t be retreived')

def add_ts(file_loc: str, dt: datetime):
    """
    Adds timestamp to the image and overwrites existing
    Args:
        file_loc: location of image to add to
        dt: datetime object
    Returns:
        None
    """
    font = ImageFont.truetype("Gidole-Regular.ttf", size=72)
    text = dt.strftime("%Y%m%d%H%M")
    my_image = Image.open(file_loc)
    image_editable = ImageDraw.Draw(my_image)
    image_editable.text((100,100), text, (250, 250, 250), font=font)
    # my_image.save("result.jpg")
    my_image.save(file_loc)


def main():
    valid_minutes = []
    counter = 1
    while counter < 60:
        valid_minutes.append(counter)
        counter+=5
    valid_minutes

    aa = datetime.utcnow()
    # Account for lag in website updating
    aa = aa - timedelta(minutes=10)
    aa.strftime("%Y%m%d%H%M")
    while aa.minute not in valid_minutes:
        aa -= timedelta(minutes=1)

    TS = aa.strftime("%Y12%-d%H%M")

    URL_MAP = {
        "visual": (
            f"https://cdn.star.nesdis.noaa.gov/GOES16/ABI/CONUS/GEOCOLOR/{TS}_GOES16-ABI-CONUS-GEOCOLOR-2500x1500.jpg",
            "/home/nmk7ii6/Pictures/visual.jpg"
        ),
        "infra": (
            f"https://cdn.star.nesdis.noaa.gov/GOES16/ABI/CONUS/Sandwich/{TS}_GOES16-ABI-CONUS-Sandwich-2500x1500.jpg",
             "/home/nmk7ii6/Pictures/infra.jpg"
        )
    }


    for i in URL_MAP:
        _ = URL_MAP[i]
        url = _[0]
        dest = _[1]
        print(url, dest)
        downloader(url, dest)

        add_ts(dest, aa)


if __name__ == "__main__":
    main()
