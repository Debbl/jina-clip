FROM python:3.9
COPY . ~/jian-clip/
WORKDIR ~/jian-clip/ 
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -y \
&& apt-get install yarn -y \
&& apt-get install ffmpeg -y \
&& echo ffmpeg -version \
&& echo yarn --version \
&& cd ./pick \
&& yarn \
&& yarn build

RUN pip install -r ./hello-jina2/requirements.txt 
RUN pip install git+https://github.com/openai/CLIP.git

EXPOSE 3001
CMD node ~/jian-clip/pick/dist/main.js
