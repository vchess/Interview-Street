package by.gstu.interviewstreet.domain;

import com.google.gson.annotations.Expose;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Entity
@Table(name = "answer_types")
public class AnswerType implements Serializable {

    @Id
    @Expose
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @Expose
    @NotEmpty
    @Column(name = "name")
    private String name;

    @Expose
    @Column(name = "default_value")
    private String defaultValue;

    @NotNull
    @OneToOne
    @PrimaryKeyJoinColumn
    private QuestionType questionType;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String type) {
        this.name = type;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public QuestionType getQuestionType() {
        return questionType;
    }

    public void setQuestionType(QuestionType questionType) {
        this.questionType = questionType;
    }

    @Override
    public String toString() {
        return "AnswerType{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", defaultValue='" + defaultValue + '\'' +
                ", questionType=" + questionType +
                '}';
    }
}
