FROM python:3.9.7
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY . /app
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Install AWS CLI
RUN apt-get update && \
    apt-get install -y awscli && \
    apt-get clean

# Copy detect_branch.sh script
COPY detect_branch.sh /detect_branch.sh
RUN chmod +x /detect_branch.sh
RUN /bin/sh /detect_branch.sh
# Run detect_branch.sh script to determine the branch name
# RUN /bin/sh -c '/detect_branch.sh'

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

# Set the entrypoint script
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]