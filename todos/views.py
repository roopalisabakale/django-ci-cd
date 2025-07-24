

# Create your views here.
# todos/views.py
from django.shortcuts import render, redirect
from .models import Task

def todo_list(request):
    tasks = Task.objects.all()
    if request.method == 'POST':
        Task.objects.create(title=request.POST.get('title'))
        return redirect('todo_list')
    return render(request, 'todos/todo_list.html', {'tasks': tasks})

def delete_task(request, task_id):
    Task.objects.get(id=task_id).delete()
    return redirect('todo_list')