import requests

if __name__ == '__main__':
    res = requests.get('https://google.com')
    print(res.status_code)
