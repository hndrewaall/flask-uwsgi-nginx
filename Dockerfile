# Copyright 2014 Josh 'blacktop' Maine
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM nginx

MAINTAINER blacktop, https://github.com/blacktop

RUN \
  apt-get update && apt-get install -y --no-install-recommends \
    python-software-properties \
    python-setuptools \
    build-essential \
    supervisor \
    python-dev \
    python \
    git

RUN easy_install pip
RUN pip install uwsgi
RUN pip install flask
# RUN pip install supervisor-stdout
RUN mkdir -p /var/log/supervisor

# Configure Nginx
RUN rm /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/conf.d/example_ssl.conf
RUN ln -s /opt/massgo/repos/flask-uwsgi-nginx/nginx-app.conf /etc/nginx/conf.d/
RUN ln -s /opt/massgo/repos/flask-uwsgi-nginx/supervisord.conf /etc/supervisor/conf.d/

# # run pip install
# RUN pip install -r /opt/massgo/repos/mgaladder/requirements.txt

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
