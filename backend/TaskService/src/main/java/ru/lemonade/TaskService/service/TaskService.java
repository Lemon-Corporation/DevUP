package ru.lemonade.TaskService.service;

import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.lemonade.TaskService.dto.task.TaskDto;
import ru.lemonade.TaskService.dto.task.TaskWithOptionsDto;
import ru.lemonade.TaskService.dto.task.create.CreateTaskDto;
import ru.lemonade.TaskService.dto.task.create.CreateTaskWithOptionsDto;
import ru.lemonade.TaskService.model.answer.OptionsAnswer;
import ru.lemonade.TaskService.model.task.Task;
import ru.lemonade.TaskService.model.task.TaskComplexity;
import ru.lemonade.TaskService.model.task.TaskTag;
import ru.lemonade.TaskService.model.task.TaskType;
import ru.lemonade.TaskService.repository.*;
import ru.lemonade.TaskService.settings.Constants;

import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Transactional
public class TaskService {
    private final TaskRepository taskRepository;
    private final TaskComplexityRepository taskComplexityRepository;
    private final TaskTypeRepository taskTypeRepository;
    private final TaskTagRepository taskTagRepository;
    private final OptionsAnswerRepository optionsAnswerRepository;

    private long getOptionsAnswerTypeId() {
        return taskTypeRepository.findByTitle(Constants.OPTION_TASK_TYPE).get().getId();
    }
    @Transactional(readOnly = true)
    public List<TaskDto> getAllTasks() {
        long optionsTypeId = getOptionsAnswerTypeId();
        return taskRepository.findAll().stream()
                .map(task -> {
                    if (task.getType().getId() == optionsTypeId) {
                        try {
                            return convertToDtoWithOptions(task);
                        } catch (EntityNotFoundException e) {
                            return convertToDto(task);
                        }
                    }
                    return convertToDto(task);
                })
                .toList();

    }

    @Transactional(readOnly = true)
    public TaskDto getTaskById(UUID id) {
        return taskRepository.findById(id)
                .map(task -> {
                    try {
                        if (task.getType().getId() == getOptionsAnswerTypeId()) {
                            return convertToDtoWithOptions(task);
                        }
                    } catch (EntityNotFoundException e) {
                        return convertToDto(task);
                    }
                    return convertToDto(task);
                })
                .orElseThrow(() -> new EntityNotFoundException("Task not found with id: " + id));
    }

    public TaskDto createTask(CreateTaskDto taskDto) {
        Task task = saveTask(taskDto);
        if (taskDto instanceof CreateTaskWithOptionsDto) {
            CreateTaskWithOptionsDto taskDtoWithOptions = (CreateTaskWithOptionsDto) taskDto;
            OptionsAnswer answer = new OptionsAnswer();
            answer.setTask(task);
            answer.setMultiple(taskDtoWithOptions.isMultiple());
            answer.setOptions(taskDtoWithOptions.getOptions());
            optionsAnswerRepository.save(answer);
            return convertToDtoWithOptions(task, answer);
        }
        return convertToDto(task);
    }

    public Task saveTask(CreateTaskDto taskDto) {
        Task task = createDtoToEntity(taskDto);
        return taskRepository.save(task);
    }

    public TaskDto updateTask(UUID id, CreateTaskDto taskDto) {
        Task existingTask = taskRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Task not found with id: " + id));

        // Обновляем основные поля
        existingTask.setTitle(taskDto.getTitle());
        existingTask.setDescription(taskDto.getDescription());

        // Обновляем тип задачи
        TaskType type = taskTypeRepository.findById(taskDto.getTypeID())
                .orElseThrow(() -> new EntityNotFoundException("TaskType not found with id: " + taskDto.getTypeID()));
        existingTask.setType(type);

        // Обновляем сложность задачи
        TaskComplexity complexity = taskComplexityRepository.findById(taskDto.getComplexityId())
                .orElseThrow(() -> new EntityNotFoundException("TaskComplexity not found with id: " + taskDto.getComplexityId()));
        existingTask.setComplexity(complexity);

        // Обновляем теги
        if (taskDto.getTagIds() != null && !taskDto.getTagIds().isEmpty()) {
            existingTask.setTags(
                    taskDto.getTagIds().stream()
                            .map(tagId -> taskTagRepository.findById(tagId)
                                    .orElseThrow(() -> new EntityNotFoundException("TaskTag not found with id: " + id)))
                            .collect(Collectors.toSet())
            );
        } else {
            existingTask.setTags(null);
        }

        existingTask = taskRepository.save(existingTask);
        return convertToDto(existingTask);
    }


    public void deleteTask(UUID id) {
        if (!taskRepository.existsById(id)) {
            throw new EntityNotFoundException("Task not found with id: " + id);
        }
        taskRepository.deleteById(id);
    }

    private Task createDtoToEntity(CreateTaskDto taskDto) {
        Task task = new Task();
        task.setTitle(taskDto.getTitle());
        task.setDescription(taskDto.getDescription());

        task.setTags(
                taskDto.getTagIds().stream()
                        .map(id -> taskTagRepository.findById(id).orElseThrow(null))
                        .filter(Objects::nonNull)
                        .collect(Collectors.toSet())
        );

        task.setType(taskTypeRepository.findById(taskDto.getTypeID()).orElseThrow(null));
        task.setComplexity(taskComplexityRepository.findById(taskDto.getComplexityId()).orElseThrow(null));
        return task;
    }

    private TaskDto convertToDto(Task task, TaskDto dto) {
        dto.setId(task.getId());
        dto.setTitle(task.getTitle());
        dto.setDescription(task.getDescription());

        if (task.getTags() != null) {
            dto.setTags(task.getTags().stream()
                    .map(tag -> new ru.lemonade.TaskService.dto.tag.TaskTagDTO(tag.getId(), tag.getTitle()))
                    .collect(Collectors.toList()));
        }

        if (task.getType() != null) {
            dto.setType(new ru.lemonade.TaskService.dto.type.TaskTypeDTO(task.getType().getId(), task.getType().getTitle()));
        }

        if (task.getComplexity() != null) {
            dto.setComplexity(new ru.lemonade.TaskService.dto.complexity.TaskComplexityDTO(
                    task.getComplexity().getId(),
                    task.getComplexity().getTitle(),
                    task.getComplexity().getSortOrder()
            ));
        }

        return dto;
    }

    private TaskDto convertToDto(Task task) {
        return convertToDto(task, new TaskDto());
    }

    private TaskWithOptionsDto convertToDtoWithOptions(Task task) {
        OptionsAnswer answer = optionsAnswerRepository.findByTaskId(task.getId()).orElseThrow(
                () -> new EntityNotFoundException("Task not found with id: " + task.getId())
        );
        return convertToDtoWithOptions(task, answer);

    }

    private TaskWithOptionsDto convertToDtoWithOptions(Task task, OptionsAnswer answer) {
        TaskWithOptionsDto taskWithOptionsDto = new TaskWithOptionsDto();
        convertToDto(task, taskWithOptionsDto);
        taskWithOptionsDto.setMultiple(answer.isMultiple());
        taskWithOptionsDto.setOptions(answer.getOptions());
        return taskWithOptionsDto;
    }
}
